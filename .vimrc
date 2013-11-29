:set autoindent
:set hlsearch
:set tabstop=4
:set shiftwidth=4
:set expandtab
:syntax on
:set mouse=a
:set number
:set nocursorline
:set nocursorcolumn
:set nowrap
":set showtabline=2 " TABS always
:set fileencodings=utf8,cp1251

"hot keys
:map <F5> :NERDTreeToggle<CR>
:map <F6> :BufExplorer<CR>

"terminal 256 colors
set t_Co=256
:colorscheme jellybeans

"gvim
:set guioptions-=T "hide toolbar
:set guioptions-=m "hide menu
:set guioptions-=r "hide scrollbar
:set guioptions-=l "hide scrollbar
"if has("gui_running")
"    set lines=999 columns=999
"endif

"auto syntax hilight
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.gyp set ft=javascript

"autosave global session
:let g:session_autosave = 'yes'
:let g:session_autoload = 'yes'
