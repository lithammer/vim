vim9script

packadd vim-lumen
augroup lumen
  autocmd!
  autocmd User LumenLight set background=light
  autocmd User LumenDark set background=dark
augroup END

augroup colorscheme_change
  autocmd!
  autocmd ColorScheme alchemist {
    hi link lspInlayHintsType Conceal
    hi link lspInlayHintsParameter Conceal
    hi link LspWarningText WarningMsg
    hi LspErrorText ctermfg=131 guifg=#af5f5f
    hi link LspHintText SignColumn
    hi link LspInformationText SignColumn
    hi LspWarningHighlight cterm=underline gui=undercurl guisp=#d7875f
    hi LspErrorHighlight cterm=underline gui=undercurl guisp=#af5f5f
    hi LspInformationHighlight cterm=underline gui=undercurl
    hi LspHintHighlight cterm=underline gui=undercurl
  }
  autocmd ColorScheme zenwritten {
    hi link LspInlayHintsParam LspInlayHint
    hi link LspInlayHintsType LspInlayHint
  }
augroup END

set termguicolors
colorscheme zenwritten
