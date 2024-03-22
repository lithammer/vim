vim9script

set laststatus=2
set showtabline=2
set guioptions-=e

# Disable fugitive statusline.
# https://github.com/tpope/vim-flagship/issues/11
# https://github.com/tpope/vim-fugitive/issues/1070
g:flagship_skip = 'FugitiveStatusline'

def LspStatus(key: string): string
  var count = lsp#lsp#ErrorCount()[key]
  var icons = {
    Error: ' ',
    Warn: ' ',
    Hint: ' ',
    Info: ' ',
    # Success: ' ',
  }

  return count > 0 ? $'{icons[key]} {count}' : ''
enddef

def LspErrorStatus(..._): string
  return LspStatus('Error')
enddef

def LspWarnStatus(..._): string
  return LspStatus('Warn')
enddef

def LspHintStatus(..._): string
  return LspStatus('Hint')
enddef

def LspInfoStatus(..._): string
  return LspStatus('Info')
enddef

def LspOkStatus(..._): string
  return lsp#lsp#ErrorCount()->values()->reduce((acc, val) => acc + val) == 0 ? '  ' : ''
enddef

# def LspStatusline(): string
#   # {'Info': 0, 'Hint': 0, 'Warn': 0, 'Error': 0}
#   var diags = lsp#lsp#ErrorCount()

#   var parts: list<string> = []
#   if diags.Error > 0
#     parts->add($'  {diags.Error}')
#   endif
#   if diags.Warn > 0
#     parts->add($'  {diags.Warn}')
#   endif
#   if diags.Hint > 0
#     parts->add($'  {diags.Hint}')
#   endif
#   if diags.Info > 0
#     parts->add($'  {diags.Info}')
#   endif

#   return parts->join(' ')
# enddef

# autocmd User Flags call Hoist('window', function('LspStatusline'), {hl: 'Error'})
autocmd User Flags call Hoist('window', function(LspErrorStatus), {hl: 'Error'})
autocmd User Flags call Hoist('window', function(LspWarnStatus), {hl: 'WarningMsg'})
autocmd User Flags call Hoist('window', function(LspHintStatus), {hl: 'MoreMsg'})
autocmd User Flags call Hoist('window', function(LspInfoStatus), {hl: 'MoreMsg'})
# autocmd User Flags call Hoist('window', function(LspOkStatus))
