" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

" Plugin to help surrond stuff with other stuff
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-sleuth'

Plug 'godlygeek/tabular'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'plasticboy/vim-markdown'
" For distraction-free writing 
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'sheerun/vim-polyglot'
Plug 'bakpakin/ats2.vim'

Plug 'ap/vim-buftabline'

Plug 'jiangmiao/auto-pairs'

"Plug 'kien/rainbow_parentheses.vim'

Plug 'cespare/vim-toml'
" Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

Plug 'itchyny/lightline.vim'

Plug 'arthurxavierx/vim-caser'

Plug 'skywind3000/asyncrun.vim'
Plug 'Shougo/vinarise.vim'

Plug 'hardliner66/vim-run'

" Plug 'mtth/scratch.vim'
Plug 'liuchengxu/vim-which-key'

Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

" Plugin for the Gleam programming language
Plug 'gleam-lang/gleam.vim'

" Plugin for Zig
Plug 'ziglang/zig.vim'

" themes
Plug 'nightsense/office'
Plug 'sts10/vim-pink-moon'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ulwlu/elly.vim'
Plug 'glepnir/oceanic-material'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'romainl/Apprentice'
Plug 'wadackel/vim-dogrun'

call plug#end()

" Always keep this at the top, just below the plug section
" This is where leader gets set
source ~/.config/nvim/defaults.vim

" This is needed for vim-dispatch to not be slow
set shell=/bin/sh
nnoremap <silent><leader>q :Copen<CR>

function! s:openFishShell()
	let old_shell = &shell
	let &shell = '/usr/bin/fish'
	execute ":term"
	execute "normal! i"
	let &shell = old_shell
endfunction

command! -nargs=0 Fish call s:openFishShell()

let g:use_async_vrun = 1

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

augroup goodbye_netrw
  au!
  autocmd VimEnter * silent! au! FileExplorer *
augroup END

augroup format_markdown
autocmd BufWritePre *.md normal ":TableFormat"
augroup END

" Configuration for vim-markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1

nnoremap <silent><leader>r :VRunAsync<cr>
nnoremap <silent><leader>s :VRun<cr>

function! s:loadEnv()
    if filereadable(".env")
        Dotenv .
    endif
endfunction

command! -nargs=0 LoadEnv call s:loadEnv()

augroup dotenv
    au VimEnter * LoadEnv
augroup END

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Lightline
let g:lightline = {
  \     'colorscheme': 'dogrun',
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

set nocompatible
filetype plugin on
syntax on
"set background=dark
colorscheme dogrun

"augroup Rainbow
"    au VimEnter * RainbowParenthesesToggle
"    au Syntax * RainbowParenthesesLoadRound
"    au Syntax * RainbowParenthesesLoadSquare
"    au Syntax * RainbowParenthesesLoadBraces
"    au Syntax * RainbowParenthesesLoadChevrons
"augroup END

"highlight Normal guifg=#b5b5aa guibg=#181818
"highlight Visual guifg=#f0f0e1 guibg=#484848
"highlight LineNr guifg=#9e9e95 guibg=#181818
"highlight CursorLineNr guifg=#a0a0a0 guibg=#303030
"highlight Pmenu guifg=#f0f0e1 guibg=#101010

nnoremap <leader>mc  :Make! clean<cr>
nnoremap <leader>mb  :Make! build<cr>
nnoremap <leader>mbr :Make! build --release<cr>
nnoremap <leader>mt  :Make! test<cr>
nnoremap <leader>mr  :Make! run<cr>
nnoremap <leader>mrr :Make! run --release<cr>

let g:coc_global_extensions = ['coc-tabnine', 'coc-rust-analyzer']

nnoremap <leader>a :CocAction<cr>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>F2 <Plug>(coc-rename)

"highlight CocErrorSign guifg=#aa0000
"highlight CocHintSign guifg=#15889d

nmap <silent> <leader>h :CocCommand rust-analyzer.toggleInlayHints<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <S-k> :call RustDocs()<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" auto import
nmap <silent> <M-Enter> <Plug>(coc-codeaction)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
  nnoremap <silent><nowait><expr> <C-p> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-p>"
  inoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-p> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
  vnoremap <silent><nowait><expr> <C-p> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-p>"
endif

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
