local function hover_fullscreen()
  local original_buf = vim.api.nvim_get_current_buf()

  local params = vim.lsp.util.make_position_params(nil, 'utf-8')
  vim.lsp.buf_request(0, 'textDocument/hover', params, function(_, result)
    if not (result and result.contents) then
      return
    end

    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    lines = vim.split(table.concat(lines, '\n'), '\n', { trimempty = true })

    if vim.tbl_isempty(lines) then
      return
    end

    -- napravi scratch buffer
    local hover_buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(hover_buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(hover_buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(hover_buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(hover_buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(hover_buf, 'modifiable', true)

    vim.api.nvim_buf_set_lines(hover_buf, 0, -1, false, lines)
    vim.lsp.util.stylize_markdown(hover_buf, lines)

    vim.api.nvim_win_set_buf(0, hover_buf)

    vim.bo[hover_buf].modifiable = false
    vim.wo.wrap = true
    vim.wo.cursorline = false

    local tmp = function()
      if vim.api.nvim_buf_is_valid(original_buf) then
        vim.api.nvim_win_set_buf(0, original_buf)
      end
      if vim.api.nvim_buf_is_valid(hover_buf) then
        vim.api.nvim_buf_delete(hover_buf, { force = true })
      end
    end

    vim.keymap.set('n', '<Esc>', tmp, { buffer = hover_buf, silent = true })
    vim.keymap.set('n', 'q', tmp, { buffer = hover_buf, silent = true })
  end)
end

return {
  setup = function()
    vim.keymap.set('n', 'gh', hover_fullscreen, { desc = 'Hover fullscreen' })
  end,
}
