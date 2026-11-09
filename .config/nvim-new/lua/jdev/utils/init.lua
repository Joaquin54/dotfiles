local M = {}

local function warn(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

-- Paths are relative to the repo root so they stay valid in the tmux pane
-- Claude runs in, whatever directory that pane sits in.
function M.relative_path(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr or 0)
  if path == "" then
    return nil
  end

  local root = vim.fs.root(path, ".git")
  if root then
    return vim.fs.relpath(root, path) or path
  end

  return vim.fn.fnamemodify(path, ":.")
end

function M.copy(text, message)
  vim.fn.setreg("+", text)
  vim.notify("Copied " .. (message or text))
end

function M.yank_file_line()
  local path = M.relative_path()
  if not path then
    warn("Buffer has no file name")
    return
  end

  M.copy(path .. "#L" .. vim.api.nvim_win_get_cursor(0)[1])
end

function M.yank_abs_path()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    warn("Buffer has no file name")
    return
  end

  M.copy(path)
end

function M.yank_code_block()
  local path = M.relative_path()
  if not path then
    warn("Buffer has no file name")
    return
  end

  -- getpos("v") is the other end of the selection; the cursor is this end
  local first = vim.fn.getpos("v")[2]
  local last = vim.api.nvim_win_get_cursor(0)[1]
  if first > last then
    first, last = last, first
  end

  local header = path .. "#L" .. first
  if last > first then
    header = header .. "-L" .. last
  end

  local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
  local fence = "```"
  local block = table.concat({
    header,
    fence .. vim.bo.filetype,
    table.concat(lines, "\n"),
    fence,
  }, "\n")

  M.copy(block, header)
end

return M
