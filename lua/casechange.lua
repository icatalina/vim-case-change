-- casechange.vim - Lets role the cases
-- Maintainer:   Ignacio Catalina
-- Version:      1.0
--
-- License:
-- Copyright (c) Ignacio Catalina.  Distributed under the same terms as Vim itself.
-- See :help license
--

local my_plugin = {}

local function with_defaults(options)
	return {
		name = options.name or "John Doe"
	}
end


function my_plugin.setup(options)
	my_plugin.options = with_defaults(options)
end

function my_plugin.is_configured()
	return my_plugin.options ~= nil
end

-- escape terminal control characters
local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- \C - case sensitive
-- \v  -  magic mode (no need for \)
local dash = vim.regex [==[\v^[a-z0-9]+(-+[a-z0-9]+)+$]==] -- [==['^[a-z0-9]+(-+[a-z0-9]+)+$]==] -- dash-case
local camel = vim.regex [==[\v\C^[a-z][a-z0-9]*([A-Z][a-z0-9]*)*$]==] --  camelCase
local snake = vim.regex [==[\v\C^[a-z0-9]+(_+[a-z0-9]+)*$]==] -- snake_case
local upper = vim.regex [==[\v\C^[A-Z][A-Z0-9]*(_[A-Z0-9]+)*$]==] -- UPPER_CASE
local pascal = vim.regex [==[\v\C^[A-Z][a-z0-9]*([A-Z0-9][a-z0-9]*)*$]==] -- PascalCase
local title = vim.regex [==[\v\C^[A-Z][a-z0-9]*( [A-Z][a-z0-9]+)*$]==] -- Title Case
local any = vim.regex [==[\v\C^[a-zA-Z][a-zA-Z0-9]*((\W)[a-zA-Z][a-zA-Z0-9]+)*$]==] -- -case etc.

local substitute = function(args)
	return vim.api.nvim_call_function("substitute", args)
end

local toupper = function(args)
	return vim.api.nvim_call_function("toupper", args)
end

local tolower = function(args)
	return vim.api.nvim_call_function("tolower", args)
end


function _G.casechange()
	vim.cmd [[noau normal! "zd]]
	-- vim.pretty_print(vim.api.nvim_get_mode())
	local str = vim.fn.getreg("z")

	-- local start = vim.api.nvim_buf_get_mark(0, '<')
	-- local finish = vim.api.nvim_buf_get_mark(0, '>')

	local sub
	if dash:match_str(str) then
		sub = substitute({ str, [[\v-+([a-z])]], [[\U\1]], 'g' })             -- camelCase
	elseif camel:match_str(str) then
		sub = substitute({ str, [[^.*$]], [[\u\0]], '' })                     -- PascalCase
	elseif upper:match_str(str) then
		local tit_under = substitute({ str, [[\v([A-Z])([A-Z]*)]], [[\1\L\2]], 'g' })
		sub = substitute({ tit_under, '_', ' ', 'g' })                        --  Title Case
	elseif pascal:match_str(str) then
		local res = substitute({ str, [==[\C^\@<![A-Z]]==], [[_\0]], 'g' })
		sub = toupper({ res })                                                -- UPPER_CASE
	elseif title:match_str(str) then
		local res = substitute({ str, ' ', '_', 'g' })
		sub = tolower({ res })                                                -- snake_case
	elseif snake:match_str(str) then
		sub = substitute({ str, [[\v_+]], '-', 'g' })                         -- dash-case
	elseif any:match_str(str) then                                          -- wurst case scenario
		local res = substitute({ str, [[\v(\W)([a-z])]], [[_\U\2]], 'g' }) -- snake_case
		sub = tolower({ res })
	end

	vim.fn.setreg("z", sub)
	vim.cmd('normal! ' .. [["zPv`[]]) -- FIXED: by using: d - rather than c at fun beg
end

vim.keymap.set('v', '~', function() casechange() end, { noremap = true, silent = true, desc = 'CaseChange Plug' })
-- vnoremap ~ "<C-R>=casechange(@z)<CR><Esc>v`[

my_plugin.options = nil
return my_plugin
