set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set noexpandtab

set hlsearch
set smartcase

set nowrap
set number
set nocursorline
set nocursorcolumn

if has('mouse')
    set mouse=a
endif

"set showtabline=2 " show tabs always
set fileencodings=utf8,cp1251
set modeline
set foldmethod=marker

set backup
set backupdir=~/.vim_backup,.,/tmp
set directory=~/.vim_swap,.,/tmp

syntax on

let NERDTreeIgnore = ['\.swp', '\.pyc']

"hot keys
map <F5> :NERDTreeMirrorToggle<CR>
map <F6> :BufExplorerRelative<CR>

"reset search
map <F3> :let @/ = ""<CR>

"provide forward deleting in Insert and Command-Line modes
inoremap <C-l> <Del>
cnoremap <C-l> <Del>

"custom digraphs
digraphs '' 769 "accent
digraphs 3. 8230 "dots

"terminal 256 colors
set t_Co=256
colorscheme jellybeans

if has("gui_running") " gui {{{1
    set guioptions-=T "hide toolbar
    set guioptions-=m "hide menu
    set guioptions-=r "hide scrollbar
    set guioptions-=l "hide scrollbar
    "set lines=999 columns=999 "maximize gvim window
    set lines=50 columns=100
endif " gui }}}1

"auto syntax hilight
if has('autocmd')
    autocmd BufNewFile,BufRead *.json set ft=javascript
    autocmd BufNewFile,BufRead *.gyp set ft=javascript
    autocmd BufNewFile,BufRead Makefile set noexpandtab
    autocmd BufNewFile,BufRead *.ejs set ft=html
endif

"autosave global session
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

"always show hidden files in NERDTree
let NERDTreeShowHidden = 1

" reset keymap {{{1

"native vim russian keyboard layout
function! ResetKeymap()
    set keymap=
    set keymap=russian-jcukenwin
    set iminsert=0
    set imsearch=-1
endfunction
command ResetKeymap call ResetKeymap()

autocmd InsertEnter * call ResetKeymap()
autocmd InsertLeave * call ResetKeymap()

ResetKeymap

" reset keymap }}}1

" toggle autoindent {{{1

"for paste in terminal (by Ctrl+Shift+V) without incremented shifting in every line
function! ToggleAutoindent()
    if &autoindent
        set noautoindent
        echo 'Auto-indent is disabled'
    else
        set autoindent
        echo 'Auto-indent is enabled'
    endif
endfunction
command ToggleAutoindent call ToggleAutoindent()

imap <F2> <Esc>:ToggleAutoindent<CR>l
nmap <F2> <Esc>:ToggleAutoindent<CR>

" toggle autoindent }}}1

" tabs hotkeys {{{1

function! NewTabWithNerdTree()
    tabnew
    NERDTreeMirrorToggle
endfunction
command NewTabWithNerdTree call NewTabWithNerdTree()

imap <F1> <Esc>:NewTabWithNerdTree<CR>
nmap <F1> <Esc>:NewTabWithNerdTree<CR>

imap <F4> <Esc><C-W><Right>:tabclose<CR>
nmap <F4> <Esc><C-W><Right>:tabclose<CR>
imap <F7> <Esc>:tabprevious<CR>
nmap <F7> <Esc>:tabprevious<CR>
imap <F8> <Esc>:tabnext<CR>
nmap <F8> <Esc>:tabnext<CR>

" tabs hotkeys }}}1

" vim: set et ts=4 sts=4 sw=4 :
