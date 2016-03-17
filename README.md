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

Open Terminal By Default
------------------------

To open a terminal with `<prefix>-c` instead of a new, empty screen, you can `let nvimux_open_term_by_default=1`.

Terminal Provider
-----------------

If you have `neoterm` installed, it will be used.
`neoterm` was a hard dependency before, but now it will fall back to default neovim `terminal`.

The only current problem with this is that there is no 'toggling' for terminals opened without neoterm.

TODO
----

There are some things I wish to do:

- [x] Allow alternate tmux prefix
- [ ] Enable alternate commands to commands (i.e. `<C-b>c` could open a terminal on a new tab)
- [ ] Add more tmux bindings
- [ ] Allow toggling mappings for terminal mode
