vim9script

packadd vim-lumen
augroup lumen
  autocmd!
  autocmd User LumenLight set background=light
  autocmd User LumenDark set background=dark
augroup END
g:lumen_light_colorscheme = 'lunaperche'
g:lumen_dark_colorscheme = 'lunaperche'

def CustomZenwritten()
  hi link LspInlayHintsParam LspInlayHint
  hi link LspInlayHintsType LspInlayHint
enddef

def CustomLunaperche()
  hi link LspInlayHintsType Conceal
enddef

augroup colorscheme_change | autocmd!
  autocmd ColorScheme zenwritten CustomZenwritten()
  autocmd ColorScheme lunaperche CustomLunaperche()
augroup END

set termguicolors
colorscheme lunaperche
