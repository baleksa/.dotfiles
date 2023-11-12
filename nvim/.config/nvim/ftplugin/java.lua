if vim.b.did_my_ftplugin then
  return
end
vim.b.did_my_ftplugin = true

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = "/home/baleksa/.local/share/jdtlsws" .. project_name
--                                                         ^^
--                                               string concattenation in Lua
--
local on_attach = function(_, bufnr)
  local bufopts = { silent = true, buffer = bufnr }
  local bind = function(m, lhs, rhs)
    vim.keymap.set(m, lhs, rhs, bufopts)
  end
  local lspbuf = vim.lsp.buf

  bind("n", "K", lspbuf.hover)
  bind("n", "gd", lspbuf.definition)
  bind("n", "gD", lspbuf.declaration)
  bind("n", "gi", lspbuf.implementation)
  bind("n", "go", lspbuf.type_definition)
  bind("n", "gr", lspbuf.references)
  bind("i", "<C-h>", lspbuf.signature_help)
  bind("n", "<leader>rn", lspbuf.rename)
  bind("n", "<leader>ca", lspbuf.code_action)

  bind("n", "<leader>d", vim.diagnostic.open_float)
  bind("n", "[d", vim.diagnostic.goto_prev)
  bind("n", "]d", vim.diagnostic.goto_next)
  bind("n", "gl", vim.diagnostic.setloclist)

  bind("n", "<leader>f", vim.lsp.buf.format)

  require("jdtls.setup").add_commands()
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/jdtls",
    "-configuration ~/.cache/jdtls",
    "-data",
    workspace_dir,
  },
  on_attach = on_attach,
  capabilities = capabilities,

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {},
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
