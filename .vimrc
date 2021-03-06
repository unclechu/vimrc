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
if v:version >= 703
	set colorcolumn=80
endif

if has('mouse')
	set mouse=a
endif

"set showtabline=2 " show tabs always
set fileencodings=utf8,cp1251
set modeline
set foldmethod=marker

let mapleader = ','

"backups and swap {{{1

set backup

let g:backups_and_swap_home_dir = expand('~')

let g:tmp_dir = g:backups_and_swap_home_dir . '/.vim_backup'
if !isdirectory(g:tmp_dir)
	call mkdir(g:tmp_dir)
endif
let &backupdir = g:tmp_dir . ',.,/tmp'

let g:tmp_dir = g:backups_and_swap_home_dir . '/.vim_swap'
if !isdirectory(g:tmp_dir)
	call mkdir(g:tmp_dir)
endif
let &directory = g:tmp_dir . ',.,/tmp'

unlet g:backups_and_swap_home_dir
unlet g:tmp_dir

"backups and swap }}}1

syntax on

let NERDTreeIgnore = ['\.swp', '\.swo', '\.pyc', '__pycache__']

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

" colors {{{1

let g:colorscheme = 'solarized'

" terminal mode
if !has("gui_running")
	let g:colorscheme = 'darkburn'
endif

set t_Co=256
exec 'colorscheme ' . g:colorscheme

"light
if g:colorscheme == 'tango-morning' || g:colorscheme == 'solarized'
	highlight SpecialKey guifg=#f4ce81 ctermfg=222 guibg=#efefce ctermbg=230
else "dark
	highlight SpecialKey guifg=#340 ctermfg=53 guibg=#111 ctermbg=234
endif

" colors }}}1

" ExpandAllFolds {{{1

" expand all folds in every tabs and windows
function! ExpandAllFolds()
	let l:tab_n = tabpagenr()
	let l:win_n = winnr()
	tabdo windo norm! zR
	exec 'tabn' . l:tab_n
	exec l:win_n . 'wincmd w'
endfunction
command ExpandAllFolds call ExpandAllFolds()

" ExpandAllFolds }}}1

" DeleteHiddenBuffers {{{1

" (c) http://stackoverflow.com/a/8459043/774228
function DeleteHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
endfunction
command DeleteHiddenBuffers call DeleteHiddenBuffers()
imap <F10> <Esc>:DeleteHiddenBuffers<CR>li
nmap <F10> <Esc>:DeleteHiddenBuffers<CR>

" DeleteHiddenBuffers }}}1

" hl tabs by hotkey {{{1

let g:listchars_original=&listchars
let g:listchars_onlytab='tab:>-'

function! ToggleTabsHL()
	let l:lc = &listchars
	if l:lc == g:listchars_onlytab
		let &listchars = g:listchars_original
		let l:tab_n = tabpagenr()
		let l:win_n = winnr()
		tabdo windo set nolist
		exec 'tabn' . l:tab_n
		exec l:win_n . 'wincmd w'
		echo 'Tabs highlighting is disabled'
	else
		let &listchars = g:listchars_onlytab
		let l:tab_n = tabpagenr()
		let l:win_n = winnr()
		tabdo windo set list
		exec 'tabn' . l:tab_n
		exec l:win_n . 'wincmd w'
		let g:listchars_original = l:lc
		echo 'Tabs highlighting is enabled'
	endif
endfunction
command ToggleTabsHL call ToggleTabsHL()

imap <F9> <Esc>:ToggleTabsHL<CR>li
nmap <F9> <Esc>:ToggleTabsHL<CR>

" hl tabs by hotkey }}}1

if has("gui_running") " gui {{{1
	set guioptions-=T "hide toolbar
	set guioptions-=m "hide menu
	set guioptions-=r "hide scrollbar
	set guioptions-=l "hide scrollbar
	"set lines=999 columns=999 "maximize gvim window
	set lines=50 columns=100
endif " gui }}}1

"python-mode configs
let g:pymode_rope = 0
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_cwindow = 0
let g:pymode_lint_options_pep8 = {
		\ 'max_line_length': 80,
		\ 'ignore': 'W191'
	\ }
let g:pymode_virtualenv = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"let g:pymode_folding = 0
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>e'

"auto syntax hilight
if has('autocmd')
	autocmd BufNewFile,BufRead *.json set ft=javascript
	autocmd BufNewFile,BufRead *.json.example set ft=javascript
	autocmd BufNewFile,BufRead *.gyp set ft=javascript
	autocmd BufNewFile,BufRead *.yaml.example set ft=yaml
	autocmd BufNewFile,BufRead Makefile set noexpandtab
	autocmd BufNewFile,BufRead *.ejs set ft=html
	autocmd BufNewFile,BufRead *.scss set ft=scss.css
endif

"autosave global session
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

"always show hidden files in NERDTree
let NERDTreeShowHidden = 1

" set tab size {{{1
function! TabSize(size)
	set noet
	let &ts = a:size
	let &sts = a:size
	let &sw = a:size
endfunction
function! ETabSize(size)
	call TabSize(a:size)
	set et
endfunction
command! -nargs=1 TabSize call TabSize(<f-args>)
command! -nargs=1 ETabSize call ETabSize(<f-args>)
" set tab size }}}1

" reset keymap {{{1

"native vim russian keyboard layout
function! ResetKeymap()
	set keymap=
	set keymap=russian-jcukenwin
	set iminsert=0
	set imsearch=-1
	let &langmap = 'йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj'.
		\ ',лk,дl,э'',яz,чx,сc,мv,иb,тn,ьm,б\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU'.
		\ ',ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Э\",ЯZ,ЧX,СC,МV,ИB,ТN'.
		\ ',ЬM,Б\<,Ю\>,Ё\~'
endfunction
command ResetKeymap call ResetKeymap()

autocmd InsertEnter * call ResetKeymap()
autocmd InsertLeave * call ResetKeymap()

ResetKeymap

" reset keymap }}}1

" toggle autoindent {{{1

let g:smartindent_enabled = &smartindent

"for paste in terminal (by Ctrl+Shift+V) without incremented shifting in every line
function! ToggleAutoindent()
	if &autoindent
		let g:smartindent_enabled = &smartindent
		set noautoindent
		set nosmartindent
		echo 'Auto-indent is disabled'
	else
		set autoindent
		if g:smartindent_enabled
			set smartindent
		endif
		echo 'Auto-indent is enabled'
	endif
endfunction
command ToggleAutoindent call ToggleAutoindent()

imap <F2> <Esc>:ToggleAutoindent<CR>li
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

"autoclose {{{1

let g:autoclose_enabled = 0

function! ToggleAutoClose(silent)
	if g:autoclose_enabled == 0
		inoremap  {  {}<Esc>i
		inoremap  (  ()<Esc>i
		inoremap  [  []<Esc>i
		inoremap  '  ''<Esc>i
		inoremap  "  ""<Esc>i
		let g:autoclose_enabled = 1
		if !a:silent
			echo 'Autoclose enabled'
		endif
	else
		iunmap  {
		iunmap  (
		iunmap  [
		iunmap  '
		iunmap  "
		let g:autoclose_enabled = 0
		if !a:silent
			echo 'Autoclose disabled'
		endif
	endif
endfunction
command ToggleAutoClose call ToggleAutoClose(0)

nmap <Leader>b <Esc>:ToggleAutoClose<CR>

"enable autoclose at start
"call ToggleAutoClose(1)

"autoclose }}}1

" vim: set noet fenc=utf-8 :
