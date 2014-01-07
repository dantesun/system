" Python specific settings.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal formatoptions=croql

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()
setlocal omnifunc=pythoncomplete#Complete
setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
setlocal makeprg=python\ %
setlocal foldmethod=indent
