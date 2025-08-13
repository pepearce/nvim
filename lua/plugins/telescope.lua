-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8", -- or the latest stable version
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim", -- uncomment if using fzf
    build = "make",                             -- required for telescope-fzf-native
  },
  config = function()
    local telescope_setup, telescope = pcall(require, "telescope")
    if not telescope_setup then
      return
    end

    local actions_setup, actions = pcall(require, "telescope.actions")
    if not actions_setup then
      return
    end

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "__pycache__",
          "%.DS_Store",
          "venv/",
          "%.env",
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
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
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
    })

    -- telescope.load_extension("fzf")
  end,
}
