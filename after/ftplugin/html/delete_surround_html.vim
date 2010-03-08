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

nnoremap dshu :call Delete_surround_html('ul')<cr>
nnoremap dshl :call Delete_surround_html('li')<cr>
nnoremap dshd :call Delete_surround_html('div')<cr>
nnoremap dshs :call Delete_surround_html('span')<cr>
nnoremap dshu :call Delete_surround_html('ul')<cr>
nnoremap dshf :call Delete_surround_html('form')<cr>
nnoremap dshs :call Delete_surround_html('span')<cr>
nnoremap dsht :call Delete_surround_html('table')<cr>
nnoremap dshr :call Delete_surround_html('tr')<cr>
nnoremap dshc :call Delete_surround_html('td')<cr>
nnoremap dshp :call Delete_surround_html('p')<cr>


nnoremap dsdb :call Delete_surround_django('block')<cr>
nnoremap dsdc :call Delete_surround_django('comment')<cr>
nnoremap dsdi :call Delete_surround_django_if()<cr>
nnoremap dsdw :call Delete_surround_django('with')<cr>

nnoremap dshu :call Delete_surround_html('ul')<cr>
nnoremap dshl :call Delete_surround_html('li')<cr>
nnoremap dshd :call Delete_surround_html('div')<cr>
nnoremap dshs :call Delete_surround_html('span')<cr>
nnoremap dshu :call Delete_surround_html('ul')<cr>
nnoremap dshf :call Delete_surround_html('form')<cr>
nnoremap dshs :call Delete_surround_html('span')<cr>
nnoremap dsht :call Delete_surround_html('table')<cr>
nnoremap dshr :call Delete_surround_html('tr')<cr>
nnoremap dshc :call Delete_surround_html('td')<cr>


nnoremap dsdb :call Delete_surround_django('block')<cr>
nnoremap dsdc :call Delete_surround_django('comment')<cr>
nnoremap dsdi :call Delete_surround_django_if()<cr>
nnoremap dsdw :call Delete_surround_django('with')<cr>
