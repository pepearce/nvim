-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "%.git/",
        "__pycache__",
        "%.DS_Store",
        "venv/",
        "dist",
        "build",
        "%.jpg",
        "%.jpeg",
        "%.png",
        "%.svg",
        "%.pdf",
        "%.zip",
      },
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55 },
        width = 0.85,
        height = 0.85,
        preview_cutoff = 120,
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--no-ignore",
      },
    },
    pickers = {
      find_files = {
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--no-ignore",
          "-g",
          "!.git",
          "-g",
          "!node_modules",
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
}
