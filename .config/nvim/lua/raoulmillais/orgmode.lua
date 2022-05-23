local orgmode = require('orgmode')

-- Load custom tree-sitter grammar for org filetype
orgmode.setup_ts_grammar()

orgmode.setup({
  org_agenda_files = {'~/org-mode/**/*'},
  org_default_notes_file = '~/org-mode/refile.org',
})
