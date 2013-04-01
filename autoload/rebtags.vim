" File:        rebtags.vim
" Last Change: 2013-03-31
" Description: vim plugin to easy rebuild tags file
" Maintainer:  Jesús Espino <jespinog@gmail.com>
" License:     This file is placed in the public domain.

function! s:GetProjectRootPath(root_directory)
python << EOF
import vim import os
try:
    working_directory = os.path.abspath(os.getcwd())
    root_markers = vim.eval('g:rebtags_root_markers')
    root_directory = vim.bindeval('a:root_directory')
    finished = False
    while working_directory != "/" and finished == False:
        for marker in root_markers:
            marker_file = os.path.join(working_directory, marker)
            if os.path.exists(marker_file):
                root_directory[0] = working_directory
                finished = True
                break
        working_directory = os.path.dirname(working_directory)
except Exception, e:
    print e
EOF
endfunction

function! s:RebuildTags(root_directory)
python << EOF
import vim
import os
try:
    extra_args = vim.eval('g:rebtags_extra_arguments')
    ctags_command = vim.eval('g:rebtags_ctags_command')
    ctags_config_file = vim.eval('g:rebtags_ctags_config_file')
    root_directory = vim.bindeval('a:root_directory')
    config_file = os.path.join(root_directory[0], ctags_config_file)

    os.chdir(root_directory[0])
    if os.path.exists(config_file):
        os.system('cat "%s" | xargs %s %s 2>&1 > /dev/null' % (config_file, ctags_command, extra_args))
    else:
        os.system('%s %s 2>&1 > /dev/null' % (ctags_command, extra_args))
except Exception, e:
    print e
EOF
endfunction

function! s:AutoAddProjectTags(root_directory)
python << EOF
import vim
import os
try:
    root_directory = vim.bindeval('a:root_directory')
    tags_file = os.path.join(root_directory[0], 'tags')
    vim.command('set tags+=%s' % tags_file)
except Exception, e:
    print e
EOF
endfunction

function! rebtags#RebuildTags()
    let s:root_directory = ['']
    call s:GetProjectRootPath(s:root_directory)
    call s:RebuildTags(s:root_directory)
endfunction

function! rebtags#AutoAddProjectTags()
    let s:root_directory = ['']
    call s:GetProjectRootPath(s:root_directory)
    call s:AutoAddProjectTags(s:root_directory)
endfunction
