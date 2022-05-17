function tabs#Stab()
  var tabstop = str2nr(input('set tabstop = softtabstop = shiftwidth = '))
  if tabstop > 0
    &l:sts = tabstop
    &l:ts = tabstop
    &l:sw = tabstop
  endif
  redraw
  call SummarizeTabs()
endfunction

function tabs#SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop=' .. &l:ts
    echon ' shiftwidth=' .. &l:sw
    echon ' softtabstop=' .. &l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

