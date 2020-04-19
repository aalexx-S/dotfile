
"*****************************************
"Tabe label
"*****************************************
" tabe labels setting
fu! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	" append file name
	let winnr = tabpagewinnr(a:n)
	let name = fnamemodify(bufname(buflist[winnr - 1]), ':t')
	let s = empty(name) ? '[unnamed]' : name
	" Add '+' if one of the buffers in the tab page is modified
	for bufnr in buflist
		if getbufvar(bufnr, "&modified")
			let s .= '[+]'
		  	break
		endif
	endfor
	return s
endfu
fu! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
	" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" display tabnumber (for use with <count>gt, etc)
		let s .= ' ('. (i+1) . ') '

		" the label is made by MyTabLabel()
		let s .= '%{MyTabLabel(' . (i + 1) . ')}'

		if i+1 < tabpagenr('$')
			let s .= ' '
		endif
	endfor
	return s
endfu
set tabline=%!MyTabLine()

