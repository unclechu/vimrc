"shows file lines for copy-paste from vim without X

function s:pybase64enc(to_encode)
    let encoded = ''
    python <<EOF
import vim
import base64
to_encode = vim.eval('a:to_encode')
encoded = base64.b64encode(to_encode)
vim.command("let encoded = '"+ encoded +"'")
EOF
    return encoded
endfunction

" shows selected lines in shell (for terminal copy-paste)
function s:filelines() range
    let to_encode = ''
    for linenum in range(a:firstline, a:lastline)
        if linenum > a:firstline
            let to_encode = to_encode . "\n"
        endif
        let to_encode = to_encode . getline(linenum)
    endfor
    exec ":!echo '".s:pybase64enc(to_encode)."' | base64 --decode"
endfunction

command -range FileLines <line1>,<line2>call s:filelines()
