"shows file lines for copy-paste from vim without X

function s:filelines() range
    exec ':!head -'.a:lastline.' '.expand('%:p').'|tail -'.(a:lastline-a:firstline+1)
endfunction

command -range FileLines <line1>,<line2>call s:filelines()
