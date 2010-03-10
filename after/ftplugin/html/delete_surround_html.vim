" after/ftplugin/html/delete_surround_html.vim
"
" For Deleting Surrounding html tags
"
" This plugin is inspired by Tim Popes surround.vim delete-surround-tag 'dst'
" mapping. It will let you delete the surrounding tag of a specified type
" rather than just the immediate tag.
"
function! Delete_surround_html(type)
    call Delete_surround_tag('<'.a:type.'[ >]', '</' . a:type .  '>', '>')
endfunction

function! Delete_surround_django(type)
    call Delete_surround_tag('{% *'.a:type.' .*%}','{% *end'.a:type. ' *%}','}')
endfunction

function! Delete_surround_django_if()
    call Delete_surround_django('if\(equal\|notequal\|changed\|\)')
endfunction

function! Delete_surround_tag(start,end,tag_end)

    let pos = getpos(".")

    if  (searchpair(a:start,'', a:end, 'b') == 0)
        return ''
    endif

    let a = getpos(".")
    call search (a:tag_end, 'e')
    let b = getpos(".")

    call setpos(".", pos)

    call searchpair(a:start,'', a:end, '')

    let c = getpos(".")
    call search (a:tag_end, 'e')
    let d = getpos(".")

    "special case for same line
    if a[1] == c[1]
        let offset  = b[2] - a[2]
        let c[2] = c[2] - offset -1
        let d[2] = d[2] - offset
    endif
    call setpos(".", a)
    exec 'norm df' . a:tag_end

    call setpos(".", c)
    exec 'norm df' . a:tag_end

    call setpos(".", pos)
endfunction


let g:delete_surround_django_{char2nr("b")} = 'block'
let g:delete_surround_django_{char2nr("c")} = 'comment'
let g:delete_surround_django_{char2nr("i")} = 'if\(equal\|notequal\|changed\|\)'
let g:delete_surround_django_{char2nr("w")} = 'with'
let g:delete_surround_django_{char2nr("f")} = 'for'

let g:delete_surround_html_{char2nr("u")} ='ul'
let g:delete_surround_html_{char2nr("l")} ='li'
let g:delete_surround_html_{char2nr("d")} ='div'
let g:delete_surround_html_{char2nr("s")} ='span'
let g:delete_surround_html_{char2nr("u")} ='ul'
let g:delete_surround_html_{char2nr("f")} ='form'
let g:delete_surround_html_{char2nr("s")} ='span'
let g:delete_surround_html_{char2nr("t")} ='table'
let g:delete_surround_html_{char2nr("r")} ='tr'
let g:delete_surround_html_{char2nr("c")} ='td'
let g:delete_surround_html_{char2nr("p")} ='p'

function! Delete_surround_dj()
    echo "delete - surround - django - (b)lock / (c)omment / (i)f* / (w)ith / (f)or :"
    let c = getchar()

    try
        call Delete_surround_django(g:delete_surround_django_{c})
    finally 
        return ''
    endtry
endfunction

function! Delete_surround_ht()
    echo "delete - surround - html - (u)l / (l)i / (d)iv / (s)pan / (f)orm / (t)able / t(r) / (c)td / (p):"
    let c = getchar()
    try
        call Delete_surround_html(g:delete_surround_html_{c})
    finally 
        return ''
    endtry
endfunction

nnoremap dsd :call Delete_surround_dj()<cr>
nnoremap dsh :call Delete_surround_ht()<cr>


"nnoremap dshu :call Delete_surround_html('ul')<cr>
"nnoremap dshl :call Delete_surround_html('li')<cr>
"nnoremap dshd :call Delete_surround_html('div')<cr>
"nnoremap dshs :call Delete_surround_html('span')<cr>
"nnoremap dshu :call Delete_surround_html('ul')<cr>
"nnoremap dshf :call Delete_surround_html('form')<cr>
"nnoremap dshs :call Delete_surround_html('span')<cr>
"nnoremap dsht :call Delete_surround_html('table')<cr>
"nnoremap dshr :call Delete_surround_html('tr')<cr>
"nnoremap dshc :call Delete_surround_html('td')<cr>
"nnoremap dshp :call Delete_surround_html('p')<cr>


"nnoremap dsdb :call Delete_surround_django('block')<cr>
"nnoremap dsdc :call Delete_surround_django('comment')<cr>
"nnoremap dsdi :call Delete_surround_django_if()<cr>
"nnoremap dsdw :call Delete_surround_django('with')<cr>
