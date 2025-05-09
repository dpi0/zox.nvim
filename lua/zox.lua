local M = {}

M.config = {
  fzf_opts = {
    prompt = "Zoxide> ",
  },
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- Change Neovim's current directory
local function change_directory(path)
  vim.cmd("cd " .. vim.fn.fnameescape(path))
  vim.notify("Changed directory to: " .. path, vim.log.levels.INFO)
end

function M.fuzzy_find_dir()
  -- Check if fzf-lua is executable
  local ok, fzf_lua = pcall(require, "fzf-lua")
  if not ok then
    vim.notify("fzf-lua is required for this plugin", vim.log.levels.ERROR)
    return
  end

  -- Query zoxide
  local handle = io.popen("zoxide query -l")
  if not handle then
    vim.notify("Failed to run zoxide command", vim.log.levels.ERROR)
    return
  end

  local result = handle:read("*a")
  handle:close()

  -- Split result into lines
  local lines = {}
  for line in result:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  local opts = vim.tbl_deep_extend("force", {
    prompt = M.config.fzf_opts.prompt,
    actions = {
      ["default"] = function(selected)
        -- Get the first string
        if selected and #selected > 0 then
          change_directory(selected[1])
        end
      end,
    },
  }, M.config.fzf_opts)

  fzf_lua.fzf_exec(lines, opts)
end

return M
