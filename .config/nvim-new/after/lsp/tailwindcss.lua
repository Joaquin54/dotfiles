-- lspconfig's root list ends with ".git" as a tailwind v4 fallback, which starts
-- the server in every git repo. The spec wants it only where Tailwind is real:
-- a config file, or a tailwindcss dependency in package.json.
local config_files = {
  "tailwind.config.js",
  "tailwind.config.cjs",
  "tailwind.config.mjs",
  "tailwind.config.ts",
  "postcss.config.js",
  "postcss.config.cjs",
  "postcss.config.mjs",
  "postcss.config.ts",
}

local function declares_tailwind(path)
  local ok, text = pcall(vim.fn.readfile, path)
  if not ok then
    return false
  end

  local decoded = vim.json.decode(table.concat(text, "\n"), { luanil = { object = true } })
  if type(decoded) ~= "table" then
    return false
  end

  for _, field in ipairs({ "dependencies", "devDependencies" }) do
    if type(decoded[field]) == "table" and decoded[field].tailwindcss then
      return true
    end
  end

  return false
end

return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    local found = vim.fs.find(config_files, { path = fname, upward = true })[1]
    if found then
      return on_dir(vim.fs.dirname(found))
    end

    for _, manifest in ipairs(vim.fs.find("package.json", { path = fname, upward = true, limit = math.huge })) do
      if declares_tailwind(manifest) then
        return on_dir(vim.fs.dirname(manifest))
      end
    end
    -- No marker: on_dir is never called, so the server does not start
  end,
}
