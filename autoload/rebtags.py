# -*- coding: utf-8 -*-
# File:        rebtags.py
# Last Change: 2013-04-03
# Description: vim plugin to easy rebuild tags file
# Maintainer:  Jesús Espino <jespinog@gmail.com>
# License:     This file is placed in the public domain.

import vim
import os


class RebTags(object):
    def get_settings(self):
        self.root_markers = vim.eval('g:rebtags_root_markers')
        self.extra_args = vim.eval('g:rebtags_extra_arguments')
        self.ctags_command = vim.eval('g:rebtags_ctags_command')
        self.ctags_config_file = vim.eval('g:rebtags_ctags_config_file')
        self.root_path = self.get_root_path()

    def get_root_path(self):
        try:
            working_directory = os.path.abspath(os.getcwd())
            while working_directory != "/":
                for marker in self.root_markers:
                    marker_file = os.path.join(working_directory, marker)
                    if os.path.exists(marker_file):
                        return working_directory
                working_directory = os.path.dirname(working_directory)
        except Exception, e:
            print e
        return ''

    def rebuild_tags(self):
        try:
            self.get_settings()
            config_file = os.path.join(self.root_path, self.ctags_config_file)

            os.chdir(self.root_path)
            if os.path.exists(config_file):
                os.system('cat "%s" | xargs %s %s 2>&1 > /dev/null' %
                          (config_file, self.ctags_command, self.extra_args))
            else:
                os.system('%s %s 2>&1 > /dev/null' % (self.ctags_command, self.extra_args))
        except Exception, e:
            print e

    def auto_add_project_tags(self):
        try:
            self.get_settings()
            tags_file = os.path.join(self.root_path, 'tags')
            vim.command('set tags+=%s' % tags_file)
        except Exception, e:
            print e
