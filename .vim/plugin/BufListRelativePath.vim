" relative paths (of pwd) in buffers list

function s:BufExplorerRelative()
    BufExplorer
    set modifiable
    let cwd = getcwd()
    if len(getcwd()) > 0
        for linenum in range(line('^'), line('$'))
            let curline = getline(linenum)
            let replacement = substitute(curline, ' '.getcwd().'  ', ' ./ ', 'g')
            if curline ==# replacement
                let replacement = substitute(curline, ' '.getcwd().' ', ' ./ ', 'g')
                if curline ==# replacement
                    let replacement = substitute(curline, ' '.getcwd(), ' .', 'g')
                endif
            endif
            if curline !=# replacement
                call setline(linenum, replacement)
            endif
        endfor
    endif
endfunction

command BufExplorerRelative call s:BufExplorerRelative()
