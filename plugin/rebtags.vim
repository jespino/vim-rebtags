" File:        rebtags.vim
" Last Change: 2013-03-31
" Description: vim plugin to easy rebuild tags file
" Maintainer:  Jesús Espino <jespinog@gmail.com>
" License:     This file is placed in the public domain.

if !has('python')
    echo 'Python 2 is needed'
    finish
endif

if exists('g:loaded_rebtags')
    finish
endif
let g:loaded_rebtags = 1

if !exists('g:rebtags_root_markers')
    let g:rebtags_root_markers = ['.git', '.hg', '_darcs', '.ctags', '.svn', '.bzr']
endif

if !exists('g:rebtags_extra_arguments')
    let g:rebtags_extra_arguments = ''
endif

if !exists('g:rebtags_ctags_command')
    let g:rebtags_ctags_command = 'ctags'
endif

if !exists('g:rebtags_ctags_config_file')
    let g:rebtags_ctags_config_file = '.ctags'
endif

if !exists('g:rebtags_auto_add_project_tags')
    let g:rebtags_add_my_project_tags = 1
endif

if g:rebtags_auto_add_project_tags
    call rebtags#AutoAddProjectTags()
endif

command! -nargs=0 RebuildTags call rebtags#RebuildTags()
