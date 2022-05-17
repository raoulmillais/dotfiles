function tabs#Strip()
  " Save the last search and cursor position
  var _s = @/
  var l = line(".")
  var c = col(".")

  " Remove trailing whitespace characters
  :%s/\s\+$//e

  " Reset last search position
  @/ = _s
  " Put the cursor back where it was
  call cursor(l, c)
enddef
