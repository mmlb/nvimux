NVIMUX
======

This plugin is a very simple set of keybindings that try to mimic tmux on neovim.

Currently, there are no customisation and no fancy settings. I plan to have those anywhere in the future though.

Feel free to use!

Also, I'll be very glad if you could open a PR helping enhance this.

Alternate Prefix
----------------

Nvimux now allows alternate tmux prefix.

By doing `let g:nvimux_prefix='<C-a>'` you can override the default `<C-b>`.

TODO
----

There are some things I wish to do:

- [x] Allow alternate tmux prefix
- [ ] Enable alternate commands to commands (i.e. `<C-b>c` could open a terminal on a new tab)
- [ ] Add more tmux bindings
- [ ] Allow toggling mappings for terminal mode
