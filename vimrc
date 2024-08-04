vim9script

# https://github.com/vim/vim/issues/11729
# https://sw.kovidgoyal.net/kitty/faq/#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
# Mouse support
set mouse=a
set ttymouse=sgr
set balloonevalterm
# Styled and colored underline support
&t_AU = "\e[58:5:%dm"
&t_8u = "\e[58:2:%lu:%lu:%lum"
&t_Us = "\e[4:2m"
&t_Cs = "\e[4:3m"
&t_ds = "\e[4:4m"
&t_Ds = "\e[4:5m"
&t_Ce = "\e[4:0m"
# Strikethrough
&t_Ts = "\e[9m"
&t_Te = "\e[29m"
# Truecolor support
&t_8f = "\e[38:2:%lu:%lu:%lum"
&t_8b = "\e[48:2:%lu:%lu:%lum"
&t_RF = "\e]10;?\e\\"
&t_RB = "\e]11;?\e\\"
# Bracketed paste
&t_BE = "\e[?2004h"
&t_BD = "\e[?2004l"
&t_PS = "\e[200~"
&t_PE = "\e[201~"
# Cursor control
&t_RC = "\e[?12$p"
&t_SH = "\e[%d q"
&t_RS = "\eP$q q\e\\"
&t_SI = "\e[5 q"
&t_SR = "\e[3 q"
&t_EI = "\e[1 q"
&t_VS = "\e[?12l"
# Focus tracking
&t_fe = "\e[?1004h"
&t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
# Window title
&t_ST = "\e[22;2t"
&t_RT = "\e[23;2t"

# vim hardcodes background color erase even if the terminfo file does
# not contain bce. This causes incorrect background rendering when
# using a color theme with a background color in terminals such as
# kitty that do not support background color erase.
&t_ut = ''

unlet! g:skip_defaults_vim
source $VIMRUNTIME/defaults.vim

def PackagerInit(pack: any)
  pack.add('kristijanhusak/vim-packager', {'type': 'opt'})

  pack.add('airblade/vim-gitgutter')
  pack.add('AndrewRadev/splitjoin.vim')
  pack.add('cohama/lexima.vim')
  pack.add('github/copilot.vim')
  pack.add('girishji/autosuggest.vim')
  pack.add('girishji/easyjump.vim')
  pack.add('girishji/fFtT.vim')
  pack.add('girishji/scope.vim')
  pack.add('girishji/vimcomplete')
  pack.add('habamax/vim-shout')
  pack.add('hrsh7th/vim-vsnip')
  pack.add('hrsh7th/vim-vsnip-integ')
  pack.add('lifepillar/vim-colortemplate')
  pack.add('ludovicchabant/vim-gutentags')
  pack.add('markonm/traces.vim')
  pack.add('romainl/vim-qf')
  pack.add('tpope/vim-endwise')
  pack.add('tpope/vim-eunuch')
  pack.add('tpope/vim-flagship')
  pack.add('tpope/vim-fugitive')
  pack.add('tpope/vim-repeat')
  pack.add('tpope/vim-sleuth')
  pack.add('tpope/vim-surround')
  pack.add('tpope/vim-unimpaired')
  pack.add('tpope/vim-vinegar')
  pack.add('vimpostor/vim-lumen', {'type': 'opt'})
  pack.add('wellle/targets.vim')
  pack.add('yegappan/cscope')
  pack.add('yegappan/fileselect')
  pack.add('yegappan/greplace')
  pack.add('yegappan/lsp')
  pack.add('yegappan/mru')
  pack.add('yegappan/taglist')

  # Filetype plugins.
  pack.add('ericvw/vim-nim')
  pack.add('gleam-lang/gleam.vim')
  pack.add('google/vim-jsonnet')
  pack.add('vim-crystal/vim-crystal')
  # pack.add('zah/nim.vim')

  # Colorschemes.
  pack.add('habamax/vim-alchemist')
  pack.add('habamax/vim-bronzage')
  pack.add('habamax/vim-nod')
  pack.add('habamax/vim-saturnite')
  pack.add('zenbones-theme/zenbones.nvim')
enddef

packadd vim-packager
packager#setup(function('PackagerInit'))

packadd comment
packadd! cfilter
packadd! editorconfig
packadd! matchit

var vimdir = $MYVIMRC->fnamemodify(':p:h')

set autoread
set breakindent
set breakindentopt=shift:2
set completepopup+=highlight:Pmenu,border:off
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set fillchars+=vert:│,diff:╱
set formatoptions+=1j
set grepformat^=%f:%l:%c:%m
set grepprg=rg\ --vimgrep
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set list listchars=tab:\|\ ,nbsp:․,trail:·,extends:…,precedes:…
set mouse=
set nowrap
set number
&showbreak = "\u21AA "
set sidescroll=1
set sidescrolloff=4
set signcolumn=number
set smartcase
set smarttab
set tabstop=4 softtabstop=4 shiftwidth=4
set updatetime=300
&viminfofile = vimdir .. '/viminfo'
set virtualedit=block
set wildignorecase
set wildmenu wildcharm=<c-z> wildoptions=pum,fuzzy,tagfile pumheight=20
set wildmode=longest,full

&directory = vimdir .. '/swap//'
&backupdir = vimdir .. '/backup'
&undodir = vimdir .. '/undo'
set backup
set undofile

g:netrw_altfile = 1
g:netrw_liststyle = 3
g:is_posix = 1

# Use CTRL-L to clear the highlighting and call :diffupdate.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

g:qf_auto_open_quickfix = 1
g:qf_auto_open_loclist = 1

def Grep(...args: list<string>): string
  return system(join([&grepprg] + [expandcmd(join(args, ' '))], ' '))
enddef

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

# Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

# Enable the :Man command shipped inside Vim's man filetype plugin.
if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man'
  runtime ftplugin/man.vim
endif
# vi: ts=2 sts=2 sw=2 et
