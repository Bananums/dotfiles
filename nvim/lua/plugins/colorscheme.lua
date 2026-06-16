return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    -- One of the "excetpions" to using config for a plugin is to load the colorscheme.
    config = function()
      vim.cmd.colorscheme("catppuccin-macchiato")

      -- Change currentline color to a faded yellow
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFC2", bold = true })
    end,
  },

}
