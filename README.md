# casechange.vim

![demo](https://user-images.githubusercontent.com/4542735/39995493-b4d45c28-57bf-11e8-9246-22b30e142bc0.gif)

## Introduction

`CaseChange` is a plugin for rotating through different casing styles. It aims to
fix the behaviour of `~` in visual mode.

## Usage

Select the block of text you want to apply `CaseChange` to and press `~`

```vim
helloWorld
HelloWorld
HELLO_WORLD
hello_world
hello-world
```

For example, if you wish to change the current word, you could press `viw~` and then keep
pressing `~` until you get to the right case.

## Keymaps

The only keymap that this plugin sets is `~`, you can prevent this by setting:

```vim
let g:casechange_nomap = 1
```

## License

Copyright (c) Ignacio Catalina. Distributed under the same terms as Vim itself. See `:help license`.
