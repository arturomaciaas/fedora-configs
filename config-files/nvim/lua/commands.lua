local function activate_venv()
  local cwd = vim.fn.getcwd()
  local venv_names = { ".venv", "venv", "env" }
  local venv_path = nil

  for _, name in ipairs(venv_names) do
    local path = cwd .. "/" .. name
    if vim.fn.isdirectory(path) == 1 then
      venv_path = path
      break
    end
  end

  if venv_path then
    vim.env.VIRTUAL_ENV = venv_path
    vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
    print("Activated virtual environment: " .. venv_path)
    
    -- Restart LSP clients to pick up the new environment
    if vim.fn.exists(":LspRestart") == 2 then
      vim.cmd("LspRestart")
      print("Restarted LSP clients.")
    else
      print("LspRestart not available. Please restart Neovim.")
    end
  else
    print("No virtual environment found in " .. cwd)
  end
end

vim.api.nvim_create_user_command("Venv", activate_venv, {})
