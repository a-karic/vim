" Sets leader key to ,
:let mapleader = ","

" For pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

" Set line numbers"
set nu

" Enable mouse
set mouse=a

" No swap files
set noswapfile

" Disable ALE on start
autocmd VimEnter * ALEDisable
autocmd VimEnter * highlight ALEWarning ctermbg=238

set rtp+=~/.fzf
let g:ackprg = 'ag --nogroup --nocolor --column'

" Map JK keys to esc
:imap jk <Esc>

" Solarized color scheme
syntax enable
set background=light
colorscheme jellybeans

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
highlight VertSplit ctermbg=16 ctermfg=lightgrey

" Edit another file in the same direcotr as the current file
" uses expression to extract path rom current fiel's path
nmap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
" nmap <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
nmap <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

map <Leader>ee :e #<cr>
map <Leader>us :s/\%V /_/g<cr>
map <Leader>nt :NERDTreeToggle<cr>
map <Leader>s :term 
nmap <space><space> df<space>
nmap '' ci'
nmap "" ci"
" map <Leader>at :ALEToggle<cr>
map <Leader>A :Ags '<C-R>+' app/
map <Leader>a :Ag<CR>
map <Leader>ev :Eview<Space>
map <Leader>ec :Econtroller<cr>
map <Leader>vc :Vcontroller<cr>
map <Leader>em :Emodel<cr>
map <Leader>t :Rails<cr>
map <Leader>r :Rails routes<cr>

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <C-c> "+y
imap <C-v> <ESC>"+gpa
cmap <C-v> <C-r>+
map <C-p> :Files<CR>
map <C-f> :Ags '<C-R>+' %<CR>

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" Gif config
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Set the tag file search order
set tags=./tags;

" alternative to <C-]>
" place your cursor on an id or class and hit <leader>]
" to jump to the definition
nnoremap <leader>] :tag /<c-r>=expand('<cword>')<cr><cr>
nnoremap <leader>[ :Ack <c-r>=expand('<cword>') . ' app/'<cr><cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Simple re-format for minified Javascript
" function! UnMinify()
"   %s/{\ze[^\r\n]/{\r/g
"   %s/){/) {/g
"   %s/};\?\ze[^\r\n]/\0\r/g
"   %s/;\ze[^\r\n]/;\r/g
"   %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
"   normal ggVG=
" endfunction

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
