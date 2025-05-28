-- Optimized LSP setup with deferred loading
local lspconfig = require("lspconfig")

-- Cache commonly used modules
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- Get capabilities once
local capabilities = require('blink.cmp').get_lsp_capabilities()

local function on_attach(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr })
end

-- Global override for floating preview border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Optimized server setup function
local function setup_server(server_name, config)
  config = config or {}
  config.on_attach = config.on_attach or on_attach
  config.capabilities = config.capabilities or capabilities
  config.handlers = config.handlers or handlers
  
  lspconfig[server_name].setup(config)
end

-- Setup servers in batches using vim.schedule to avoid blocking
local function setup_servers_batch(servers)
  local index = 1
  local function setup_next()
    if index > #servers then
      return
    end
    
    local server = servers[index]
    if type(server) == "string" then
      setup_server(server)
    else
      setup_server(server.name, server.config)
    end
    
    index = index + 1
    if index <= #servers then
      vim.schedule(setup_next)
    end
  end
  
  setup_next()
end

-- Batch 1: Basic servers (immediate)
local basic_servers = { "bashls", "graphql", "html", "prismals" }
setup_servers_batch(basic_servers)

-- Batch 2: Complex servers (deferred)
vim.schedule(function()
  local complex_servers = {
    {
      name = "tailwindcss",
      config = {
        capabilities = (function()
          local tailwind_capabilities = vim.deepcopy(capabilities)
          tailwind_capabilities.textDocument.completion.completionItem.snippetSupport = true
          tailwind_capabilities.textDocument.colorProvider = { dynamicRegistration = false }
          tailwind_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
          return tailwind_capabilities
        end)(),
        filetypes = require("kickstart.plugins.lsp.servers.tailwindcss").filetypes,
        init_options = require("kickstart.plugins.lsp.servers.tailwindcss").init_options,
        on_attach = require("kickstart.plugins.lsp.servers.tailwindcss").on_attach,
        settings = require("kickstart.plugins.lsp.servers.tailwindcss").settings,
        flags = {
          debounce_text_changes = 1000,
        },
      }
    },
    {
      name = "cssls",
      config = {
        on_attach = require("kickstart.plugins.lsp.servers.cssls").on_attach,
        settings = require("kickstart.plugins.lsp.servers.cssls").settings,
      }
    },
    {
      name = "eslint",
      config = {
        on_attach = require("kickstart.plugins.lsp.servers.eslint").on_attach,
        settings = require("kickstart.plugins.lsp.servers.eslint").settings,
        flags = {
          allow_incremental_sync = false,
          debounce_text_changes = 1000,
          exit_timeout = 1500,
        },
      }
    },
    {
      name = "jsonls",
      config = {
        settings = require("kickstart.plugins.lsp.servers.jsonls").settings,
      }
    },
    {
      name = "lua_ls",
      config = {
        settings = require("kickstart.plugins.lsp.servers.lua_ls").settings,
      }
    },
    {
      name = "vuels",
      config = {
        filetypes = require("kickstart.plugins.lsp.servers.vuels").filetypes,
        init_options = require("kickstart.plugins.lsp.servers.vuels").init_options,
        on_attach = require("kickstart.plugins.lsp.servers.vuels").on_attach,
        settings = require("kickstart.plugins.lsp.servers.vuels").settings,
      }
    }
  }
  
  setup_servers_batch(complex_servers)
end)

-- UFO setup (deferred)
vim.schedule(function()
  local ufo_utils = require("kickstart.plugins.lsp.utils._ufo")
  local ufo_config_handler = ufo_utils.handler
  
  require("ufo").setup({
    fold_virt_text_handler = ufo_config_handler,
    close_fold_kinds_for_ft = { default = { "imports" } },
  })
end)