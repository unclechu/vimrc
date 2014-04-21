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
set modeline

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

"gvim
if has("gui_running")
    set guioptions-=T "hide toolbar
    set guioptions-=m "hide menu
    set guioptions-=r "hide scrollbar
    set guioptions-=l "hide scrollbar
    "set lines=999 columns=999 "maximize gvim window
    set lines=50 columns=100
endif

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

function! GuiTabLabel()
    let l:label = ''
    let l:bufnrlist = tabpagebuflist(v:lnum)

    for l:bufnr in l:bufnrlist
        if getbufvar(l:bufnr, "&modified")
            let l:label = '+'
            break
        endif
    endfor

    let l:label .= v:lnum . ': '

    let l:name = bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1])

    if l:name == ''
        if &buftype == 'quickfix'
            let l:name = '[Quickfix List]'
        else
            let l:name = '[No Name]'
        endif
    else
        let l:dirname = fnamemodify(l:name, ':p:h')
        let l:tail = fnamemodify(l:name, ':p:t')
        let l:name = l:tail

        " shortify paths
        if l:dirname != ''
            " remove path to current dir
            let l:cwd = getcwd()
            let l:dirnameLeftPart = strpart(l:dirname, 0, strlen(l:cwd))
            if l:cwd == l:dirnameLeftPart
                let l:dirname = strpart(l:dirname, strlen(l:cwd) + 1)
            endif

            " shortify
            let l:dirname = substitute(l:dirname, '\([^/]\)[^/]\+', '\1', 'g')
            if l:dirname != ''
                let l:name = l:dirname . '/' . l:name
            endif
        endif
    endif

    let l:label .= l:name

    return l:label
endfunction
set guitablabel=%{GuiTabLabel()}

" vim: set ts=4 sw=4 expandtab :
