-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Forward SSH yanks to the connecting terminal's clipboard with OSC 52.
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("user_ssh_clipboard", { clear = true }),
    desc = "Copy SSH yanks to the client clipboard",
    callback = function()
      local event = vim.v.event
      if event.operator == "y" and event.regname ~= "_" then
        require("vim.ui.clipboard.osc52").copy("+")(event.regcontents)
      end
    end,
  })
end

local autosave = vim.api.nvim_create_augroup("user_autosave", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = autosave,
  desc = "Save modified file buffers",
  callback = function(args)
    local bufnr = args.buf
    if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    local buffer = vim.bo[bufnr]
    if
      buffer.buftype ~= ""
      or buffer.readonly
      or not buffer.modifiable
      or not buffer.modified
      or vim.api.nvim_buf_get_name(bufnr) == ""
    then
      return
    end

    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd.update()
    end)
  end,
})
