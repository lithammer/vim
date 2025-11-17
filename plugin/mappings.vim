vim9script

import autoload 'scope/fuzzy.vim'
nnoremap <leader>ff <scriptcmd>fuzzy.File('fd -tf')<CR>
nnoremap <leader>/ <scriptcmd>fuzzy.Grep('rg --vimgrep')<CR>
nnoremap <leader>b <scriptcmd>fuzzy.Buffer()<CR>
nnoremap <leader>fm <scriptcmd>fuzzy.MRU()<CR>
nnoremap <leader>fg <scriptcmd>fuzzy.GitFile()<CR>
nnoremap <leader>h <scriptcmd>fuzzy.CmdHistory()<CR>
nnoremap <leader>t <scriptcmd>fuzzy.Tag()<CR>
nnoremap <leader>g :G<cr>
nnoremap <leader>G :tab G<cr>
