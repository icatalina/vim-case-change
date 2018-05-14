" casechange.vim - Lets role the cases
" Maintainer:   Ignacio Catalina
" Version:      1.0
"
" Installation:
" Place in either ~/.vim/plugin/casechange.vim (to load at start up) or
" ~/.vim/autoload/casechange.vim (to load automatically as needed).
"
" License:
" Copyright (c) Ignacio Catalina.  Distributed under the same terms as Vim itself.
" See :help license
"

if exists("g:loaded_casechange") || &cp || v:version < 700
    finish
endif
let g:loaded_casechange = 1


function! casechange#next(str)
    let l:snake = '^[a-z0-9]\+\(-\+[a-z0-9]\+\)\+$'
    let l:camel = '\C^[a-z][a-z0-9]*\([A-Z][a-z0-9]*\)*$'
    let l:under = '\C^[a-z0-9]\+\(_\+[a-z0-9]\+\)*$'
    let l:constant = '\C^[A-Z][A-Z0-9]*\(_[A-Z0-9]\+\)*$'
    let l:pascal = '\C^[A-Z][a-z0-9]*\([A-Z0-9][a-z0-9]*\)*$'

    if (a:str =~ l:snake)
        return substitute(a:str, '-\+\([a-z]\)', '\U\1', 'g')
    elseif (a:str =~ l:camel)
        return substitute(a:str, '^.*$', '\u\0', 'g')
    elseif (a:str =~ l:constant)
        return tolower(a:str)
    elseif (a:str =~ l:pascal)
        return toupper(substitute(a:str, '\C^\@<![A-Z]', '_\0', 'g'))
    else
        return substitute(a:str, '_\+', '-', 'g')
    endif
endfunction

if !exists("g:casechange_nomap")
    vnoremap ~ "zc<C-R>=casechange#next(@z)<CR><Esc>v`[
endif

" vim:set ft=vim et sw=4 sts=4:
