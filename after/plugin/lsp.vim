vim9script

var servers = [
  {
    name: 'awk-language-server',
    path: 'awk-language-server',
    args: [],
    filetype: ['awk'],
  },
  {
    name: 'bash-language-server',
    path: 'bash-language-server',
    args: ['start'],
    filetype: ['bash', 'sh'],
  },
  {
    name: 'biome',
    path: 'biome',
    args: ['lsp-proxy'],
    filetype: [
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    ],
    rootSearch: ['biome.json'],
    runIfSearch: ['biome.json'],
  },
  {
    path: 'clangd',
    args: ['--background-index'],
    filetype: ['c', 'cpp'],
    rootSearch: ['compile_commands.json'],
  },
  {
    path: 'crystalline',
    args: ['--stdio'],
    filetype: ['crystal'],
    rootSearch: ['shard.yml'],
  },
  {
    name: 'gopls',
    path: 'gopls',
    args: ['serve'],
    filetype: ['go', 'gomod', 'gowork', 'gotmpl', 'gohtmltmpl', 'gotexttmpl'],
    syncInit: true,
    rootSearch: ['go.work', 'go.mod'],
    workspaceConfig: {
      gopls: {
        analyses: {
          nilness: true,
          unusedparams: true,
          unusedwrite: true,
          useany: true,
        },
        hoverKind: 'FullDocumentation',
        linksInHover: false,
        gofumpt: true,
        completeUnimported: true,
        semanticTokens: true,
        staticcheck: true,
        usePlaceholders: true,
        completionDocumentation: true,
        codelenses: {
          generate: true,
          test: true,
          run_vulncheck_exp: true,
        },
        hints: {
          assignVariableTypes: false,
          compositeLiteralFields: true,
          compositeLiteralTypes: false,
          constantValues: true,
          functionTypeParameters: true,
          parameterNames: true,
          rangeVariableTypes: true,
        },
      }
    }
  },
  # {
  #   path: 'jsonnet-language-server',
  #   args: ['--tanka'],
  #   filetype: ['jsonnet', 'libsonnet'],
  # },
  {
    name: 'lua-language-server',
    path: 'lua-language-server',
    args: [],
    filetype: ['lua'],
    rootSearch: ['.luarc.json', '.luarc.jsonc'],
  },
  {
    name: 'nimlangserver',
    path: 'nimlangserver',
    args: [],
    filetype: ['nim'],
    syncInit: true,
    workspaceConfig: {}
  },
  {
    name: 'marksman',
    path: 'marksman',
    args: ['server'],
    filetype: ['markdown'],
    syncInit: true
  },
  {
    name: 'pyright',
    path: 'pyright-langserver',
    args: ['--stdio'],
    filetype: ['python'],
    rootSearch: ['pyproject.toml'],
    workspaceConfig: {
      python: {
        analysis: {
          autoImportCompletions: true,
          autoSearchPaths: true,
          # diagnosticMode: 'workspace',
          typeCheckingMode: 'basic',
          useLibraryCodeForTypes: true,
        },
      },
    },
  },
  {
    name: 'ruff',
    path: 'ruff',
    args: ['server', '--preview'],
    filetype: ['python'],
    rootSearch: ['pyproject.toml', 'ruff.toml', '.ruff.toml'],
    workspaceConfig: {},
  },
  {
    name: 'rust-analyzer',
    path: 'rust-analyzer',
    args: [],
    filetype: ['rust'],
    syncInit: true,
    rootSearch: ['Cargo.toml'],
    initializationOptions: {
      completion: {
        autoimport: {
          enable: true
        }
      }
    },
    workspaceConfig: {
      'rust-analyzer': {
        check: {
          command: 'clippy',
          features: 'all'
        },
        cargo: {
          completion: {
            postfix: {
              enable: false
            }
          },
          features: 'all'
        }
      }
    }
  },
  {
    name: 'taplo',
    path: 'taplo',
    args: ['lsp', 'stdio'],
    filetype: ['toml'],
  },
  {
    path: 'typescript-language-server',
    args: ['--stdio'],
    filetype: [
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    ],
    rootSearch: ['package.json'],
  },
  {
    name: 'vim-language-server',
    path: 'vim-language-server',
    args: ['--stdio'],
    filetype: ['vim'],
    initializationOptions: {
      isNeovim: has('nvim'),
      vimruntime: $VIMRUNTIME,
      runtimepath: &runtimepath,
      iskeyword: &iskeyword .. ',:',
      # vim-language-server doesn't handle vim9
      # diagnostic: {
      #   enable: true
      # }
    }
  },
  {
    name: 'vscode-css-language-server',
    path: 'vscode-css-language-server',
    args: ['--stdio'],
    filetype: ['css', 'scss', 'less'],
  },
  {
    name: 'vscode-html-language-server',
    path: 'vscode-html-language-server',
    args: ['--stdio'],
    filetype: ['html', 'htmldjango'],
    initializationOptions: {
      provideFormatter: true
    },
  },
  {
    name: 'vscode-json-language-server',
    path: 'vscode-json-language-server',
    args: ['--stdio'],
    filetype: ['json'],
    initializationOptions: {
      provideFormatter: true
    },
    workspaceConfig: {
      json: {
        format: { enable: true }
      }
    }
  },
]

# :help 'lsp-options'
var opts = {
  # autoComplete: true,
  autoHighlight: true,
  completionMatcher: 'icase',
  highlightDiagInline: true,
  ignoreMissingServer: true,
  semanticHighlight: true,
  showDiagOnStatusLine: true,
  # showDiagWithVirtualText: true,
  showInlayHints: true,
  snippetSupport: true,
  vsnipSupport: true,
}

g:LspOptionsSet(opts)
g:LspAddServer(servers)

import autoload 'lsp/buffer.vim' as buf

def BufHasDocumentFormattingProvider(): bool
  var lspservers: list<dict<any>> = buf.CurbufGetServers()
  for lspserver in lspservers
    if lspserver.isDocumentFormattingProvider
      return true
    endif
  endfor
  return false
enddef

def OnLspAttached()
  setlocal omnifunc=g:LspOmniFunc
  setlocal tagfunc=lsp#lsp#TagFunc
  setlocal updatetime=100
  setlocal completepopup+=highlight:Pmenu

  nnoremap <buffer> g= <cmd>LspFormat<CR>
  vnoremap <buffer> g= <cmd>LspFormat<CR>
  nnoremap <buffer> ga <cmd>LspCodeAction<CR>
  nnoremap <buffer> gd <cmd>LspGotoDefinition<CR>
  nnoremap <buffer> gD <cmd>LspGotoDeclaration<CR>
  nnoremap <buffer> gs <cmd>LspSymbolSearch<CR>
  nnoremap <buffer> gr <cmd>LspPeekReferences<CR>
  nnoremap <buffer> gi <cmd>LspGotoImpl<CR>
  nnoremap <buffer> gy <cmd>LspTypeDef<CR>
  nnoremap <buffer> <leader>r <cmd>LspRename<CR>
  nnoremap <buffer> [g <cmd>LspDiagPrev\|LspDiagCurrent<CR>
  nnoremap <buffer> ]g <cmd>LspDiagNext\|LspDiagCurrent<CR>
  nnoremap <buffer> K <cmd>LspHover<CR>

  if BufHasDocumentFormattingProvider()
    augroup lsp_format_on_save
      autocmd!
      autocmd BufWritePre <buffer> :LspFormat
    augroup END
  endif

  if g:LspOptionsGet().snippetSupport && g:LspOptionsGet().vsnipSupport
    imap <buffer><expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
    smap <buffer><expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
    imap <buffer><expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
    smap <buffer><expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
    imap <buffer><expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    smap <buffer><expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
  endif
enddef

augroup lsp
  autocmd!
  autocmd User LspAttached OnLspAttached()
augroup END

hi link LspDiagLine NONE
hi LspTextRef gui=underline cterm=underline
