" Vim syntax file
" Language:   HTMLTemplate
" Maintainer: Hinrik Örn Sigurðsson (hinrik.sigurdsson@booking.com)

if exists("b:current_syntax")
    finish
endif

if !exists("main_syntax")
    let main_syntax = "tmpl"
endif

runtime! syntax/html.vim
unlet b:current_syntax
syn cluster htmlPreproc add=@tmpl_top
syn include @perlTop syntax/perl.vim
unlet b:current_syntax

syn region tmpl_open_tag
    \ matchgroup=tmpl_tag
    \ start="\c<TMPL_\w\+"
    \ end="/\?>"
    \ contains=tmpl_arg,tmpl_var,tmpl_bracket_code

syn region tmpl_bracket_code
    \ matchgroup=tmpl_brackets
    \ start="\[%"
    \ end="%\]"
    \ contains=@perlTop
    \ contained

syn region tmpl_include
    \ matchgroup=tmpl_tag
    \ start="\c<TMPL_INCLUDE"
    \ end="/\?>"
    \ contains=tmpl_arg

syn region tmpl_block_comment
    \ matchgroup=tmpl_tag
    \ start="\c<TMPL_COMMENT>"
    \ end="\c</TMPL_COMMENT>"
    \ contains=perlTodo,@Spell

" any kind of argument: quoted strings, filenames, key=value pairs, etc
syn match tmpl_arg '"\?[-._/{}[:alnum:]]\+"\?=\?\%("\?[_[:alnum:]]\+"\?\)\?' contained
" we make template vars look like Perl vars, not like other arguments
syn match tmpl_var +[\_[:alnum:]]\+\ze\%(\s\|"\|>\)+ contained nextgroup=tmpl_dot
syn match tmpl_dot "\." contained nextgroup=tmpl_var
syn match tmpl_tag "\c</TMPL_\w\+>"
syn match tmpl_comment "\%(^\s*\)\@<=#.*" contains=perlTodo,@Spell

syn cluster tmpl_top contains=tmpl_open_tag,tmpl_include,tmpl_block_comment,tmpl_tag
syn cluster htmlTop add=tmpl_comment

hi link tmpl_tag            Preproc
hi link tmpl_arg            Special
hi link tmpl_brackets       Special
" for familiarity
hi link tmpl_comment        perlComment
hi link tmpl_block_comment  perlComment
hi link tmpl_var            perlIdentifier
hi link tmpl_dot            perlOperator

let b:current_syntax = "tmpl"
if main_syntax == "tmpl"
    unlet main_syntax
endif
