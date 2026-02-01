return {
  -- adventurous
  -- gruvbox
  -- vague
  -- rose-pine
  -- catppuccin,
  -- chance-of-storm
  -- clearance
  -- 0x7A69_dark
  -- Dark2
  -- Dim
  -- Spink
  -- Tommorow-Night-Bright

  setup = function()
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        vim.cmd [[
      highlight Normal guibg=none ctermbg=none
      highlight NormalNC guibg=none ctermbg=none
      highlight SignColumn guibg=none ctermbg=none
      highlight LineNr guibg=none ctermbg=none
      highlight Folded guibg=none ctermbg=none
      highlight NonText guibg=none ctermbg=none
      highlight VertSplit guibg=none ctermbg=none
      highlight EndOfBuffer guibg=none ctermbg=none
    ]]
      end,
    })

    -- vim.cmd.colorscheme 'adventurous'
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
