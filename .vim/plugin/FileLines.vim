"shows file lines for copy-paste from vim without X

function s:filelines() range
    let l:line = ''
    for l:linenum in range(a:firstline, a:lastline)
        let l:line = l:line . getline(linenum)
        if l:linenum < a:lastline
            let l:line = l:line . "\n"
        endif
    endfor
    echo l:line
endfunction

command -range FileLines <line1>,<line2>call s:filelines()
