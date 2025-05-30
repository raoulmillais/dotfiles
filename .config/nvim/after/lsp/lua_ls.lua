return {
  settings = {
    Lua = {
      version = "LuaJIT",
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the globals like `vim`
        globals = { "vim", "describe" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
        checkThirdParty = false,
      },
      telemetry = {
        enabled = false, -- don't send telemetry
      },
    }
  }
}
