return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>",   desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    session_lens = {
      picker = "fzf", -- Use fzf-lua as picker
      mappings = {
        delete_session = { "i", "<C-d>" },
        alternate_session = { "i", "<C-s>" },
        copy_session = { "i", "<C-y>" },
      },

      picker_opts = {
        -- For Fzf-Lua, picker_opts turns into winopts
        -- See: https://github.com/ibhagwan/fzf-lua#customization
        height = 0.5,
        width = 0.8,
      },
    },
  },
}
