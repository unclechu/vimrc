set autoindent
set hlsearch
set smartcase
set tabstop=4
set shiftwidth=4
set expandtab
syntax on
if has('mouse')
    set mouse=a
endif
set number
set nocursorline
set nocursorcolumn
set nowrap
"set showtabline=2 " TABS always
set fileencodings=utf8,cp1251

"hot keys
map <F5> :NERDTreeMirrorToggle<CR>
map <F6> :BufExplorer<CR>

"terminal 256 colors
set t_Co=256
colorscheme jellybeans
set term=screen-256color
if &l:term != 'screen-256color'
    set term=xterm-256color
endif
echo 'term='.&l:term

"gvim
set guioptions-=T "hide toolbar
set guioptions-=m "hide menu
set guioptions-=r "hide scrollbar
set guioptions-=l "hide scrollbar
"if has("gui_running")
"    set lines=999 columns=999
"endif

"auto syntax hilight
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.gyp set ft=javascript

"autosave global session
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

"always show hidden files in NERDTree
let NERDTreeShowHidden = 1

"native vim russian keyboard layout
function ResetKeymap()
    set keymap=
    set keymap=russian-jcukenwin
    set iminsert=0
    set imsearch=-1
endfunction
command ResetKeymap call ResetKeymap()
autocmd InsertEnter * call ResetKeymap()
autocmd InsertLeave * call ResetKeymap()
ResetKeymap

" vim: set ts=4 sw=4 expandtab :
