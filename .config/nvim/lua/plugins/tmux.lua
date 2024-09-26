local c = require('core')

return {
  { 
    'benmills/vimux',
    init = function()
      local keymaps = require('config.keymaps')
      for _, km in pairs(keymaps.vimux) do
        c.nmap(unpack(km))
      end
    end
  },
  { 'benmills/vimux-golang' },
  { 'christoomey/vim-tmux-navigator' },
}
