" vim: set sw=4 sts=4 et fdm=marker:

function! s:CTest()
"python3 << EOF
"print("Hello from Vim's Python!")
"EOF
    call s:RD()
endfunction

function! s:RD()
python3 << EOF
import vim
import random
print(random.randint(0,10))

EOF
endfunction


command! CTest call s:CTest()
