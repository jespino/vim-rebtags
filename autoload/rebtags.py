# -*- coding: utf-8 -*-
# File:        rebtags.py
# Last Change: 2013-04-03
# Description: vim plugin to easy rebuild tags file
# Maintainer:  Jesús Espino <jespinog@gmail.com>
# License:     This file is placed in the public domain.

import vim
import os

def get_project_root_path():
    try:
        working_directory = os.path.abspath(os.getcwd())
        root_markers = vim.eval('g:rebtags_root_markers')
        while working_directory != "/":
            for marker in root_markers:
                marker_file = os.path.join(working_directory, marker)
                if os.path.exists(marker_file):
                    return working_directory
            working_directory = os.path.dirname(working_directory)
    except Exception, e:
        print e
    return ''

def rebuild_tags():
    try:
        root_directory = get_project_root_path()
        extra_args = vim.eval('g:rebtags_extra_arguments')
        ctags_command = vim.eval('g:rebtags_ctags_command')
        ctags_config_file = vim.eval('g:rebtags_ctags_config_file')
        config_file = os.path.join(root_directory, ctags_config_file)

        os.chdir(root_directory)
        if os.path.exists(config_file):
            os.system('cat "%s" | xargs %s %s 2>&1 > /dev/null' % (config_file, ctags_command, extra_args))
        else:
            os.system('%s %s 2>&1 > /dev/null' % (ctags_command, extra_args))
    except Exception, e:
        print e

def auto_add_project_tags():
    try:
        root_directory = get_project_root_path()
        tags_file = os.path.join(root_directory, 'tags')
        vim.command('set tags+=%s' % tags_file)
    except Exception, e:
        print e
