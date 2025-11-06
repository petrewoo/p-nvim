-- [[ AI Assistant Plugins - Claude Integration ]]

return {
  -- Avante.nvim - Claude AI integration for Neovim
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "claude",
      auto_suggestions_provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-5-20250929",
        temperature = 0,
        max_tokens = 8000,
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Alternative: CodeGPT (supports multiple AI providers including Claude)
  {
    "dpayne/CodeGPT.nvim",
    enabled = false,  -- 默认禁用，如果想用这个可以设置为 true
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require("codegpt.config")
      vim.g["codegpt_chat_completions_url"] = "https://api.anthropic.com/v1/messages"
      vim.g["codegpt_commands"] = {
        ["explain"] = {
          user_message_template = "Explain the following {{language}} code:\n\n```{{language}}\n{{text_selection}}\n```",
          model = "claude-sonnet-4-5-20250929",
        },
        ["optimize"] = {
          user_message_template = "Optimize the following {{language}} code:\n\n```{{language}}\n{{text_selection}}\n```",
          model = "claude-sonnet-4-5-20250929",
        },
        ["tests"] = {
          user_message_template = "Write tests for the following {{language}} code:\n\n```{{language}}\n{{text_selection}}\n```",
          model = "claude-sonnet-4-5-20250929",
        },
        ["debug"] = {
          user_message_template = "Find and fix bugs in the following {{language}} code:\n\n```{{language}}\n{{text_selection}}\n```",
          model = "claude-sonnet-4-5-20250929",
        },
      }
    end,
  },

  -- CopilotChat (需要 GitHub Copilot 订阅)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,  -- 默认禁用
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      model = "gpt-4",
    },
  },
}
