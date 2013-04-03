" File:        rebtags.vim
" Last Change: 2013-03-31
" Description: vim plugin to easy rebuild tags file
" Maintainer:  Jesús Espino <jespinog@gmail.com>
" License:     This file is placed in the public domain.

python << EOF
import sys
import vim
sys.path.append(vim.eval('expand("<sfile>:p:h")'))
from rebtags import RebTags
rebtags = RebTags()
EOF

function! s:RebuildTags()
python << EOF
rebtags.rebuild_tags()
EOF
endfunction

function! s:AutoAddProjectTags()
python << EOF
rebtags.auto_add_project_tags()
EOF
endfunction

function! rebtags#RebuildTags()
    call s:RebuildTags()
endfunction

function! rebtags#AutoAddProjectTags()
    call s:AutoAddProjectTags()
endfunction
