local function on_attach(client, bufnr)
  ---Utility for keymap creation.
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts string|table
  ---@param mode? string|string[]
  local function keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts }
      or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  ---For replacing certain <C-x>... keymaps.
  ---@param keys string
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(keys, true, false, true),
      "n",
      true
    )
  end

  ---Is the completion menu open?
  local function pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
  end
  local methods = vim.lsp.protocol.Methods

  keymap("grr", "<cmd>FzfLua lsp_references<cr>", "vim.lsp.buf.references()")

  keymap("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Go to type definition")

  keymap(
    "<leader>fs",
    "<cmd>FzfLua lsp_document_symbols<cr>",
    "Document symbols"
  )
  keymap("<leader>fS", function()
    -- Disable the grep switch header.
    require("fzf-lua").lsp_live_workspace_symbols({ no_header_i = true })
  end, "Workspace symbols")

  keymap("[e", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  end, "Previous error")
  keymap("]e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  end, "Next error")

  if client.supports_method(methods.textDocument_definition) then
    keymap("gD", "<cmd>FzfLua lsp_definitions<cr>", "Peek definition")
    keymap("gd", function()
      require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end, "Go to definition")
  end

  if client.supports_method(methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup(
      "mariasolos/cursor_highlights",
      { clear = false }
    )
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.supports_method(methods.textDocument_inlayHint) then
    local inlay_hints_group = vim.api.nvim_create_augroup(
      "mariasolos/toggle_inlay_hints",
      { clear = false }
    )

    -- Initial inlay hint display.
    -- Idk why but without the delay inlay hints aren't displayed at the very start.
    vim.defer_fn(function()
      local mode = vim.api.nvim_get_mode().mode
      vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
    end, 500)

    vim.api.nvim_create_autocmd("InsertEnter", {
      group = inlay_hints_group,
      desc = "Enable inlay hints",
      buffer = bufnr,
      callback = function()
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end,
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = inlay_hints_group,
      desc = "Disable inlay hints",
      buffer = bufnr,
      callback = function()
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
    })
  end

  -- Enable completion and configure keybindings.
  if client.supports_method(methods.textDocument_completion) then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    -- Use enter to accept completions.
    keymap("<cr>", function()
      return pumvisible() and "<C-y>" or "<cr>"
    end, { expr = true }, "i")

    -- Use slash to dismiss the completion menu.
    keymap("/", function()
      return pumvisible() and "<C-e>" or "/"
    end, { expr = true }, "i")

    -- Use <C-n> to navigate to the next completion or:
    -- - Trigger LSP completion.
    -- - If there's no one, fallback to vanilla omnifunc.
    keymap("<C-n>", function()
      if pumvisible() then
        feedkeys("<C-n>")
      else
        if next(vim.lsp.get_clients({ bufnr = 0 })) then
          vim.lsp.completion.trigger()
        else
          if vim.bo.omnifunc == "" then
            feedkeys("<C-x><C-n>")
          else
            feedkeys("<C-x><C-o>")
          end
        end
      end
    end, "Trigger/select next completion", "i")

    -- Buffer completions.
    keymap("<C-u>", "<C-x><C-n>", { desc = "Buffer completions" }, "i")

    -- Use <Tab> to navigate between snippet tabstops,
    -- or select the next completion.
    -- Do something similar with <S-Tab>.
    keymap("<Tab>", function()
      if pumvisible() then
        feedkeys("<C-n>")
      elseif vim.snippet.active() then
        vim.snippet.jump(1)
      else
        feedkeys("<Tab>")
      end
    end, {}, { "i", "s" })
    keymap("<S-Tab>", function()
      if pumvisible() then
        feedkeys("<C-p>")
      elseif vim.snippet.active() then
        vim.snippet.jump(-1)
      else
        feedkeys("<S-Tab>")
      end
    end, {}, { "i", "s" })

    keymap("<C-f>", function()
      if vim.snippet.active() then
        vim.snippet.jump(1)
      else
        feedkeys("<C-f>")
      end
    end, {}, { "i", "s" })

    keymap("<C-b>", function()
      if vim.snippet.active() then
        vim.snippet.jump(-1)
      else
        feedkeys("<C-b>")
      end
    end, {}, { "i", "s" })

    -- Inside a snippet, use backspace to remove the placeholder.
    keymap("<BS>", "<C-o>s", {}, "s")
  end
end

vim.diagnostic.config({
  -- virtual_text = false,
  signs = false,
})

--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
  for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    for pattern, hl_group in pairs({
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
      ["|%S-|"] = "@text.reference",
    }) do
      local from = 1 ---@type integer?
      while from do
        local to
        from, to = line:find(pattern, from)
        if from then
          vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
            end_col = to,
            hl_group = hl_group,
          })
        end
        from = to and to + 1 or nil
      end
    end
  end
end

-- Override the virtual text diagnostic handler so that the most severe diagnostic is shown first.
local show_handler = vim.diagnostic.handlers.virtual_text.show
assert(show_handler)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
  show = function(ns, bufnr, diagnostics, opts)
    table.sort(diagnostics, function(diag1, diag2)
      return diag1.severity > diag2.severity
    end)
    return show_handler(ns, bufnr, diagnostics, opts)
  end,
  hide = hide_handler,
}

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP keymaps",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- I don't think this can happen but it's a wild world out there.
    if not client then
      return
    end

    on_attach(client, args.buf)
  end,
})

vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
  contents = vim.lsp.util._normalize_markdown(contents, {
    width = vim.lsp.util._make_floating_popup_size(contents, opts),
  })
  vim.bo[bufnr].filetype = "markdown"
  vim.treesitter.start(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

  add_inline_highlights(bufnr)

  return contents
end

local lsp = require("lspconfig")
lsp.gopls.setup({})
lsp.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  on_init = function(client)
    local path = vim.tbl_get(client, "workspace_folders", 1, "name")
    if not path then
      vim.print("no workspace")
      return
    end
    client.settings = vim.tbl_deep_extend("force", client.settings, {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          },
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        },
      },
    })
  end,
})
