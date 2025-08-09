const LABEL_NAME = "needs info"

function checkVersion(content, version) {
	return content.includes(` (${version} `)
}

function commentBody(creator) {
	return `Hey @${creator}, I noticed that you're not using the newest nightly version, please:

- Confirm whether the problem can still be reproduced in the newest nightly.
- Update the issue with the debug info from the newest nightly.

Issues marked with \`${LABEL_NAME}\` will be closed if they have no activity within 3 days.
`
}

module.exports = async ({ github, context, core }) => {
	async function nightlyVersion() {
		try {
			const { data: { commit } } = await github.rest.repos.getBranch({
				...context.repo,
				branch: "main",
			})
			return commit.sha.slice(0, 7)
		} catch (e) {
			core.error(`Error fetching latest version: ${e.message}`)
			return null
		}
	}

	async function hasLabel(id, label) {
		try {
			const { data: labels } = await github.rest.issues.listLabelsOnIssue({
				...context.repo,
				issue_number: id,
			})
			return labels.some(l => l.name === label)
		} catch (e) {
			core.error(`Error checking labels: ${e.message}`)
			return false
		}
	}

	async function updateLabels(id, mark, body) {
		try {
			const marked = await hasLabel(id, LABEL_NAME)
			if (mark && !marked) {
				await github.rest.issues.addLabels({
					...context.repo,
					issue_number: id,
					labels: [LABEL_NAME],
				})
				await github.rest.issues.createComment({
					...context.repo,
					issue_number: id,
					body,
				})
			} else if (!mark && marked) {
				await github.rest.issues.removeLabel({
					...context.repo,
					issue_number: id,
					name: LABEL_NAME,
				})
			}
		} catch (e) {
			core.error(`Error updating labels: ${e.message}`)
		}
	}

	async function closeOldIssues() {
		try {
			const { data: issues } = await github.rest.issues.listForRepo({
				...context.repo,
				state: "open",
				labels: LABEL_NAME,
			})

			const now = new Date()
			const threeDaysAgo = new Date(now - 3 * 24 * 60 * 60 * 1000)

			for (const issue of issues) {
				const markedAt = new Date(issue.labels_at || issue.created_at)
				if (markedAt < threeDaysAgo) {
					await github.rest.issues.update({
						...context.repo,
						issue_number: issue.number,
						state: "closed",
						state_reason: "not_planned",
					})
					await github.rest.issues.createComment({
						...context.repo,
						issue_number: issue.number,
						body: `This issue has been automatically closed because it was marked as \`${LABEL_NAME}\` for more than 3 days without updates.
If the problem persists, please file a new issue with the newest nightly version.`,
					})
				}
			}
		} catch (e) {
			core.error(`Error checking old issues: ${e.message}`)
		}
	}

	async function main() {
		const newest = await nightlyVersion()
		if (!newest) return

		if (context.eventName === "schedule") {
			await closeOldIssues()
			return
		}

		if (context.eventName === "issues") {
			const id = context.payload.issue.number
			if (await hasLabel(id, "bug")) {
				const content = context.payload.issue.body || ""
				const creator = context.payload.issue.user.login

				const isNewest = checkVersion(content, newest)
				await updateLabels(id, !isNewest, commentBody(creator))
			}
		}
	}

	await main()
}
