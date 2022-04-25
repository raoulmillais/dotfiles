vim9script

export def Stab()
  var tabstop = str2nr(input('set tabstop = softtabstop = shiftwidth = '))
  if tabstop > 0
    &l:sts = tabstop
    &l:ts = tabstop
    &l:sw = tabstop
  endif
  redraw
  call SummarizeTabs()
enddef

export def SummarizeTabs()
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
enddef

