return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "python",
        "go",
        "rust",
        "c",
        "cpp",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}