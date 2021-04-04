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

" \C - case sensitive
" \v  -  magic mode (no need for \)
function! casechange#next(str)
    let l:dash = '\v^[a-z0-9]+(-+[a-z0-9]+)+$' " '^[a-z0-9]+(-+[a-z0-9]+)+$'  dash-case
    let l:camel = '\v\C^[a-z][a-z0-9]*([A-Z][a-z0-9]*)*$'     " camelCase
    let l:snake = '\v\C^[a-z0-9]+(_+[a-z0-9]+)*$'           "snake_case
    let l:upper = '\v\C^[A-Z][A-Z0-9]*(_[A-Z0-9]+)*$'       "UPPER_CASE
    let l:pascal = '\v\C^[A-Z][a-z0-9]*([A-Z0-9][a-z0-9]*)*$'   "PascalCase
    let l:title = '\v\C^[A-Z][a-z0-9]*( [A-Z][a-z0-9]+)*$'     "Title Case
    let l:any = '\v\C^[a-zA-Z][a-zA-Z0-9]*(( |_|-)[a-zA-Z][a-zA-Z0-9]+)*$'     "aNy_casE  Any-case etc.


    if (a:str =~ l:dash)
        return substitute(a:str, '\v-+([a-z])', '\U\1', 'g')          "camelCase
    elseif (a:str =~ l:camel)
        return substitute(a:str, '^.*$', '\u\0', 'g')                 "PascalCase
    elseif (a:str =~ l:upper)
        let l:tit_under = substitute(a:str, '\v([A-Z])([A-Z]*)','\1\L\2','g')
        return substitute(l:tit_under,'_',' ','g')                        " Title Case
    elseif (a:str =~ l:pascal)
        return toupper(substitute(a:str, '\C^\@<![A-Z]', '_\0', 'g'))          "UPPER_CASE
    elseif (a:str =~ l:title)
        return tolower(substitute(a:str, ' ', '_', 'g'))               " snake_case
    elseif (a:str =~ l:snake)   "snake
        return substitute(a:str, '_\+', '-', 'g')                      "dash-case
    else  " (a:str =~ l:any)   - wurst case scenario
        return tolower(substitute(a:str, '\v( |_|-)([a-z])', '_\U\2', 'g'))          "snake_case
    endif
endfunction

if !exists("g:casechange_nomap")
    vnoremap ~ "zc<C-R>=casechange#next(@z)<CR><Esc>v`[
endif

" vim:set ft=vim et sw=4 sts=4:
