" return a representation of the selected text suitable for use as a search pattern
function! functions#GetVisualSelection()
    let old_reg = @v
    normal! gv"vy
    let raw_search = @v
    let @v = old_reg
    return substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction
