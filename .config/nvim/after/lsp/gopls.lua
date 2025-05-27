-- Copied from https://codeberg.org/gpanders/dotfiles/src/branch/master/.config/nvim/lsp/gopls.fnl and converted to lua

-- Better find_root that reads the value of GOMOD in go env and uses that
local function find_root(buf, cb)
  local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(buf))

  return vim.system({"go", "env", "-json", "GOMOD"}, {cwd = cwd}, function (out)
    if (out.code == 0) then
      local status, result = pcall(vim.json.decode, out.stdout)
      if ((status == true) and ((type(result) == "table") and (nil ~= result.GOMOD))) then
        -- It will be /dev/null if we're not in a go module
        if (result.GOMOD ~= "/dev/null") then
          return cb(vim.fs.dirname(result.GOMOD))
        end
      end
    end
  end)
end

return {
  filetypes = {"go", "gomod", "gowork", "gosum"},
  cmd = {"gopls"},
  root_dir = find_root,
  settings = {
    autoformat = true,
    gopls = {
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        nilness = true
      },
      -- experimental features
      semanticTokens = true,
      staticcheck = true -- runs checks described at staticcheck.dev
    }
  }
}
