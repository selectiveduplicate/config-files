let mapleader = ","

set tabstop=4
set shiftwidth=4
set noexpandtab
set nobackup
set nowritebackup
set whichwrap+=<,>,h,l,[,]
set incsearch
set ignorecase
set smartcase
set smartindent
set wildmenu
set wildmode=full
set foldmethod=indent
set foldenable
set foldlevelstart=10
set foldnestmax=10
set ruler
set colorcolumn=80
set laststatus=2
set splitright
set splitbelow
set backspace=indent,eol,start
set nowrap
set nohlsearch
set timeoutlen=2000
set mouse=
set noswapfile
"set nosmd
set hidden

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set relativenumber
set number

if ! exists("g:use_async_vrun")
    let g:use_async_vrun = 0
endif

nnoremap <leader>n :set invnumber invrelativenumber<CR>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"inoremap <Up> <Nop>
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>

nnoremap <silent><leader>k :bn<CR>
nnoremap <silent><leader><leader>k :bn!<CR>
nnoremap <silent><leader>j :bp<CR>
nnoremap <silent><leader><leader>j :bp!<CR>
nnoremap <silent><leader>d :bd<CR>
nnoremap <silent><leader><leader>d :bd!<CR>
nnoremap <silent><leader>w :w<CR>
" nnoremap <silent><leader>wq :wq<CR>
" nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader>o gf<ESC>

" force quit with non-zero exit code
nnoremap <silent><leader><leader>q :cq!<CR>
" nnoremap <silent><leader><leader>wq :w<CR>:cq<CR>
nnoremap <silent><leader>co :copen<CR>



""""""################# Terminal Stuff ######################""""""
" exit integrated terminal mode - assumes buffer
tnoremap <Esc> <C-\><C-N>:bd!<CR>
" cargo run if rust
command! -nargs=* Run :call <SID>CargoRun(<q-args>)
function! s:CargoRun(param)
    if &filetype == 'rust'
        :split
        ene | call termopen('cargo r -- ' . (a:param)) | startinsert
    endif
endfunction
" cargo build if rust
command! -nargs=0 Build :call <SID>CargoBuild()
function! s:CargoBuild()
    if &filetype == 'rust'
        :split
        ene | call termopen('cargo build') | startinsert
    endif
endfunction
" cargo check if rust
command! -nargs=0 Check :call <SID>CargoCheck()
function! s:CargoCheck()
    if &filetype == 'rust'
        :split
        ene | call termopen('cargo check') | startinsert
    endif
endfunction
" cargo clippy if rust
command! -nargs=0 Clippy :call <SID>CargoClippy()
function! s:CargoClippy()
    if &filetype == 'rust'
        :split
        ene | call termopen('cargo clippy') | startinsert
    endif
endfunction
" cargo test if rust
command! -nargs=0 Test :call <SID>CargoTest()
function! s:CargoTest()
    if &filetype == 'rust'
        :split
        ene | call termopen('cargo test') | startinsert
    endif
endfunction
" cargo docs if rust
command! -nargs=0 Doc :call <SID>CargoDoc()
function! s:CargoDoc()
    if &filetype == 'rust'
        :split
        :silent !cargo doc -q --open
    endif
endfunction
""""""################# Terminal Stuff ######################""""""

nnoremap <leader>cc :!cargo clean<cr>
nnoremap <leader>ch :call <SID>CargoCheck()<cr>
nnoremap <leader>cb :call <SID>CargoBuild()<cr>
nnoremap <leader>ct :call <SID>CargoTest()<cr>
nnoremap <leader>cr :call <SID>CargoRun(<q-args>)<cr>
nnoremap <leader>cd :call <SID>CargoDoc()<cr>
nnoremap <leader>cy :call <SID>CargoClippy()<cr>
nnoremap <leader>cf :!cargo fmt<cr>

" Shortcuts for working with Go
nnoremap <leader>gt : !go test<cr>
nnoremap <leader>gb : !go build<cr>
nnoremap <leader>gr : !go run<cr>
nnoremap <leader>gf : !go fmt<cr>

" Shortcuts for working with Zig
nnoremap <leader>zt :compiler zig_test<cr>
nnoremap <leader>zm :make<cr>

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" " Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

" -----------------------------------------------------------------------------
"     - Rust help -
" -----------------------------------------------------------------------------
"function! RustDocs()
"    let l:word = expand("<cword>")
"    :call RustMan(word)
"endfunction
"
"function! RustMan(word)
"    let l:command  = ':term rusty-man ' . a:word
"    execute command
"endfunction
"
":command! -nargs=1 Rman call RustMan(<f-args>)
"nmap <leader>rd :call RustDocs()<CR>

" -----------------------------------------------------------------------------
"     - Grepping -
"     Grepping with ripgrep.
"     If you don't have ripgrep installed you are in trouble!
" -----------------------------------------------------------------------------
set grepprg=rg\ --vimgrep

function RipGrepping(search_term)
    silent! exe 'grep! -i -F "' . a:search_term . '"'
    redraw!
    if len(getqflist()) > 0 
        :copen
    endif
endfunction
command! -nargs=* Find call RipGrepping(<q-args>)

nmap <C-f> :Find 

" " vim -b : edit binary using xxd-format!
" augroup Binary
"   au!
"   au BufReadPre   *.bin,*.exe let &bin=1
"   au BufReadPost  *.bin,*.exe if &bin | %!xxd
"   au BufReadPost  *.bin,*.exe set ft=xxd | endif
"   au BufWritePre  *.bin,*.exe if &bin | %!xxd -r
"   au BufWritePre  *.bin,*.exe endif
"   au BufWritePost *.bin,*.exe if &bin | %!xxd
"   au BufWritePost *.bin,*.exe set nomod | endif
" augroup END

cmap w!! w !sudo /run/current-system/sw/bin/tee > /dev/null %
