# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Aliases ---
alias aoeu='cmatrix'
alias ls='lsd'
alias cat='bat'

# --- Functions ---
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

please() {
  sudo $(fc -ln -1)
}

# --- Paths ---
export PATH="$HOME/Scripts:/home/mac/SonarQube/sonar-scanner-7.0.1.4817-linux-x64/bin:$HOME/.cargo/bin:$PATH"
export EDITOR=nvim

# --- Zsh Options ---
setopt HIST_IGNORE_ALL_DUPS
setopt appendhistory
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
bindkey -v
WORDCHARS=${WORDCHARS//[\/]}

# --- History Substring Search Bindings ---
zmodload -F zsh/terminfo +p:terminfo

for key ('^[OA' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[OB' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down

bindkey -M viins 'jk' vi-cmd-mode
bindkey '^[^?' backward-kill-word
bindkey '^?' backward-delete-char
bindkey -M vicmd 'k' up-history
bindkey -M vicmd 'j' down-history

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)
