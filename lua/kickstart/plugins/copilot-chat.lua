-- Place in lua/custom/plugins/copilot-chat.lua
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        -- Disable suggestions but keep the core plugin
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      debug = false,
      context = 'buffer', -- Use current buffer for context
      show_help = true,
      prompts = {
        RubberDuck = {
          prompt = 'You are my rubber duck debugging partner. Help me think through this problem: $input',
        },
        SmartSolution = {
          prompt = 'Given the code context, suggest a smart approach to: $input',
        },
      },
    },
    keys = {
      {
        '<leader>cc',
        function()
          require('CopilotChat').toggle()
        end,
        desc = 'Toggle Copilot Chat',
      },
      {
        '<leader>cr',
        function()
          local input = vim.fn.input 'Rubber duck question: '
          if input ~= '' then
            require('CopilotChat').ask('RubberDuck', { input = input })
          end
        end,
        desc = 'Rubber Duck with Copilot',
      },
      {
        '<leader>cs',
        function()
          local input = vim.fn.input 'How should I: '
          if input ~= '' then
            require('CopilotChat').ask('SmartSolution', { input = input })
          end
        end,
        desc = 'Ask for Smart Solution',
      },
      {
        '<leader>cb',
        '<cmd>CopilotChatBuffer<cr>',
        desc = 'Chat with Buffer Context',
      },
      -- Selection-based chat
      {
        '<leader>cs',
        ':CopilotChatSelection<cr>',
        mode = 'v',
        desc = 'Chat with Selection',
      },
    },
  },
}
