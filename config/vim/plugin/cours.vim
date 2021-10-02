" vim: set sw=4 sts=4 et fdm=marker:

" VARIABLES: {{{1
" g:Cplugin_loaded
let s:plug_tab = get(s:, 'plug_tab', -1)
let s:plug_buf = get(s:, 'plug_buf', -1)
" }}}
" IS_LOADED: {{{1
if exists('g:Cplugin_loaded')
  finish
endif
let g:Cplugin_loaded = 1
" }}}
function! s:plug_window_exists() " {{{1
  let buflist = tabpagebuflist(s:plug_tab)
  return !empty(buflist) && index(buflist, s:plug_buf) >= 0
endfunction
" }}}
function! s:switch_in() " {{{1
  if !s:plug_window_exists()
    return 0
  endif

  if winbufnr(0) != s:plug_buf
    let s:pos = [tabpagenr(), winnr(), winsaveview()]
    execute 'normal!' s:plug_tab.'gt'
    let winnr = bufwinnr(s:plug_buf)
    execute winnr.'wincmd w'
    call add(s:pos, winsaveview())
  else 
    let s:pos = [winsaveview()]
  endif

  setlocal modifiable
  return 1
endfunction
" }}}
function! s:close_pane() " {{{1
  if b:plug_preview == 1 
    pc   
    let b:plug_preview = -1 
  else 
    bd   
  endif
endfunction
" }}}
function! s:Csyntax() "{{{1
  syntax clear
"  syntax region plug1 start=/\%1l/ end=/\%2l/ contains=plugNumber
"  syntax region plug2 start=/\%2l/ end=/\%3l/ contains=plugBracket,plugX
"  syn match plugNumber /[0-9]\+[0-9.]*/ contained
"  syn match plugBracket /[[\]]/ contained
"  syn match plugX /x/ contained
"  syn match plugDash /^-\{1}\ /
"  syn match plugPlus /^+/
"  syn match plugStar /^*/
"  syn match plugMessage /\(^- \)\@<=.*/
"  syn match plugName /\(^- \)\@<=[^ ]*:/
"  syn match plugSha /\%(: \)\@<=[0-9a-f]\{4,}$/
"  syn match plugTag /(tag: [^)]\+)/
"  syn match plugInstall /\(^+ \)\@<=[^:]*/
"  syn match plugUpdate /\(^* \)\@<=[^:]*/
"  syn match plugCommit /^  \X*[0-9a-f]\{7,9} .*/ contains=plugRelDate,plugEdge,plugTag
"  syn match plugEdge /^  \X\+$/
"  syn match plugEdge /^  \X*/ contained nextgroup=plugSha
"  syn match plugSha /[0-9a-f]\{7,9}/ contained
"  syn match plugRelDate /([^)]*)$/ contained
"  syn match plugNotLoaded /(not loaded)$/
"  syn match plugError /^x.*/
"  syn region plugDeleted start=/^\~ .*/ end=/^\ze\S/
"  syn match plugH2 /^.*:\n-\+$/
"  syn match plugH2 /^-\{2,}/
"  syn keyword Function PlugInstall PlugStatus PlugUpdate PlugClean
"  hi def link plug1       Title
"  hi def link plug2       Repeat
"  hi def link plugH2      Type
"  hi def link plugX       Exception
"  hi def link plugBracket Structure
"  hi def link plugNumber  Number
"
"  hi def link plugDash    Special
"  hi def link plugPlus    Constant
"  hi def link plugStar    Boolean
"
"  hi def link plugMessage Function
"  hi def link plugName    Label
"  hi def link plugInstall Function
"  hi def link plugUpdate  Type
"  hi def link plugError   Error
"  hi def link plugDeleted Ignore
"  hi def link plugRelDate Comment
"  hi def link plugEdge    PreProc
"  hi def link plugSha     Identifier
"  hi def link plugTag     Constant
"
"  hi def link plugNotLoaded Comment
endfunction
"}}}

" ACTIONS KEYS: {{{2
function! s:CEnter()
  echo winline() 
  
endfunction
" }}}

function! s:Ccours() " {{{2
  " VSP: {{{2
  if s:switch_in()
    if b:plug_preview == 1
      pc
    endif
    enew
  else
    execute get(g:, 'plug_window', 'vertical topleft new')
  endif
  "}}} 
  " BINDING: {{{2
  nnoremap <silent> <buffer> q :call <SID>close_pane()<cr>
  nnoremap <silent> <buffer> e :call <SID>CEnter()<cr>
  "nnoremap <silent> <buffer> U  :call <SID>status_update()<cr>
  "nnoremap <silent> <buffer> ]] :silent! call <SID>section('')<cr>
  "nnoremap <silent> <buffer> [[ :silent! call <SID>section('b')<cr>
  "}}} " 
  "BUFFER: {{{2
  let b:plug_preview = -1
  let s:plug_tab = tabpagenr()
  let s:plug_buf = winbufnr(0)
  "}}}
  " ASSIGN_NAME: {{{2
  let prefix = '[AR]'
  let name   = prefix
  let idx    = 2
  while bufexists(name)
    let name = printf('%s (%s)', prefix, idx)
    let idx = idx + 1
  endwhile
  silent! execute 'f' fnameescape(name)
  "}}}
" {{{1
  "for k in ['<cr>', 'L', 'o', 'X', 'd', 'dd']
  "  execute 'silent! unmap <buffer>' k
  "endfor
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline modifiable nospell
  "if exists('+colorcolumn')
  "  setlocal colorcolumn=
  "endif

  " footer bar
  " DRAWING: {{{1
  call setline(1, "███ ███ █ █ ██  ███")
  call setline(2, "█   █ █ █ █ █ █ █  ")
  call setline(3, "█   █ █ █ █ ██  ███")
  call setline(4, "█   █ █ █ █ █ █   █")
  call setline(5, "███ ███ ███ █ █ ███")
  "}}}
  " SYNTAX ET MODIFIABLE: {{{1
  setf nerdtree
  if exists('g:syntax_on')
    call s:Csyntax()
  endif
  setlocal nomodifiable
  "}}}
  echom "HELLO"
endfunction
" }}}

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


command! CCours call s:Ccours()
command! CTest call s:CTest()