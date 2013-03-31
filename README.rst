RebTags
=======

RebTags provides a easy way to rebuild your tags file based on your project
directory. It uses the repository directories (:code:`.git`, :code:`.hg`, :code:`_darcs`...) as
markers or a :code:`.ctags` configuration file to find where must build the tags file.

**IMPORTANT NOTE**: Take care with your :code:`.ctags` configuration and the
:code:`g:rebtags_extra_arguments` setting to no scan the generated tags file,
can enter in an infinite loop.

Configuration
-------------

To configure your tags building you can write a :code:`.ctags` (or the file in your
:code:`g:rebtags_ctags_config_file` variable) configuration file with one ctags
parameter per line in the root directory of your project.

g:rebtags_root_markers
~~~~~~~~~~~~~~~~~~~~~~
Use this to set your own root markers as replacement to the default ones
(:code:`.git`, :code:`.hg`, :code:`.svn`, :code:`.bzr`, :code:`_darcs` and :code:`.ctags`)::
  let g:rebtags_root_markers = ['.git', '.project']

g:rebtags_ctags_command
~~~~~~~~~~~~~~~~~~~~~~~
Use this to define which ctags command you want to use (the default one is
:code:`ctags`)::
  let g:rebtags_ctags_command = 'ectags'

g:rebtags_ctags_config_file
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Use this to define which filename has the ctags configuration (the default one
is :code:`.ctags`)::
  let g:rebtags_ctags_config_file = '.project_ctags'

g:rebtags_extra_arguments
~~~~~~~~~~~~~~~~~~~~~~~~~
Use this to define extra parameters to your ctags command (the default value
is no extra parameters)::
  let g:rebtags_extra_arguments = '--python-kinds --languages=python'

g:rebtags_auto_add_project_tags
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Use this to define enable or disable the automatically add of the generated
tags file to the tags setting of the vim (the default value is 1)::
  let g:rebtags_auto_add_project_tags = 0

Usage
-----

To rebuild your tags you have to run the command :code:`:RebuildTags`

You can map it as usual, for example:

.. code-block::

  map <F6> <Esc>:RebuildTags<CR>

License
-------

This plugin is placed in the public domain.

Contributing
------------

If you experience any bugs or have feature requests, please open an issue on
GitHub. Fork the source repository on GitHub and send a pull request if you
have any code improvements.
