"=============================================================================
" File:        FileLines.vim
" Description: Shows file lines for copy-paste from vim without X
" Maintainer:  Viacheslav Lotsmanov <lotsmanov89 at gmail dot com>
" Last Change: 21 April, 2014
" License:     GNU/GPLv3 by Free Software Foundation
" Required:    python 2.x, python2-base64, bash, base64
"=============================================================================

" python wrapper
function s:pybase64enc(to_encode)
    let l:encoded = ''
    python <<EOF
import vim
import base64
to_encode = vim.eval('a:to_encode')
encoded = base64.b64encode(to_encode)
vim.command("let l:encoded = '"+ encoded +"'")
EOF
    return l:encoded
endfunction

" shows selected lines in shell (for terminal copy-paste)
function s:filelines() range
    let l:to_encode = ''
    for l:linenum in range(a:firstline, a:lastline)
        if l:linenum > a:firstline
            let l:to_encode = to_encode . "\n"
        endif
        let l:to_encode = l:to_encode . getline(l:linenum)
    endfor
    exec ":!echo '" . s:pybase64enc(l:to_encode) . "' | base64 --decode"
endfunction

command -range FileLines <line1>,<line2>call s:filelines()
