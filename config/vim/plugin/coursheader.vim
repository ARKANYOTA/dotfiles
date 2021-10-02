"""
" #!/usr/bin/env python
" #vim: set sw=4 sts=4 et fdm=marker:
" #┎━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" #┃ Nom: Carlisi, Prenom: Nolan, Classe: TG 04 ┃
" #┃ Creation: 14/09/2021 15:37:20              ┃
" #┃ Mise a jour: 14/09/2021 15:37:20           ┃
" #┃ Fichier: coursheader.vim                   ┃
" #┃ Exercice fiche .                           ┃
" #┖━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


function! s:date()
	return strftime("%d/%m/%Y %H:%M:%S")
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:textline(left)
	let l:left = strpart(a:left, 0, 43)
	return "#┃ " . l:left . repeat(' ',43 - strlen(l:left)) . "┃"
endfunction

function! s:line(n)
	if a:n == 1
		return '#!/usr/bin/env python'
    elseif a:n == 2
        return  '# vim: set sw=4 sts=4 et fdm=marker:'
	elseif a:n == 3
		return '#┎━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓'
	elseif a:n == 4
		return s:textline('Nom: Carlisi, Prenom: Nolan, Classe: TG 04')
	elseif a:n == 5
		return s:textline('Creation: ' . s:date())
	elseif a:n == 6
		return s:textline('Mise a jour: ' . s:date())
	elseif a:n == 7
		return s:textline('Fichier: ' . s:filename())
	elseif a:n == 8
		return s:textline('Exercice fiche .')
	elseif a:n == 9
		return '#┖━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'
	endif
endfunction

function! s:update()
	if getline(6) =~ "#┃ " . "Mise a jour: "
		if &mod
			call setline(6, s:line(6))
		endif
		call setline(7, s:line(7))
		return 0
	endif
	return 1
endfunction

function! s:insert()
	let l:line = 9

	" empty line after header
	call append(0, "")

	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:stdheader()
	if s:update()
		call s:insert()
		call cursor(7,21)
	endif
endfunction

" Bind command and shortcut
command! Cheader call s:stdheader ()
map <F1> :Cheader<CR>
autocmd BufWritePre * call s:update ()

