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
let s:casechange = luaeval('require("casechange")')

" if s:casechange.is_configured()
  " Neovim does not expose a lua API to create commands yet
  " command! MyPluginGreet call s:casechange.greet()
" endif
