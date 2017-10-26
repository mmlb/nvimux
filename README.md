NVIMUX
======

### Lua port

This plugin is being ported to lua at [the 'lua' branch](https://github.com/hkupty/nvimux/tree/lua). This branch is frozen until porting is complete.
Feel free to test the lua version and send feedback.

### Support nvimux
Support iron.nvim development by sending me some bitcoins at `137gRFaXxJmyV23FA9PZZ6Fp8Pvs11gPPV`.


### About nvimux

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
In this case, opening a blank screen moves to `<prefix>-t`.

Terminal Provider
-----------------

Nvimux uses default neovim terminal implementation for terminal buffers (both quickterm and terminal window).

One can define a different quickterm provider via `g:nvimux_quickterm_provider` and different commands for
terminal creating/closing terminal buffers via `g:nvimux_new_term` and `g:nvimux_close_term`.

### Defining quickterm position

You can set specific values for orientation, direction and size with the variables below:

```vim
"This are the defaults
let g:nvimux_quickterm_direction = 'botright'
let g:nvimux_quickterm_orientation = 'vertical'
let g:nvimux_quickterm_size = ''
```

Overriding defaults
-------------------

If you want to override any of the predefined commands, you can define `g:nvimux_override_{command}` for any specified command.
For example, by default `<prefix>-n` will execute a `gt` (go to next tab), but you can define `let nvimux_override_n=":term<CR>"` and
`<prefix>-n` will now turn current window into a terminal.


Credits & Stuff
---------------

This plugin is developed and maintained by [Henry Kupty](http://github.com/hkupty) and it's completely free to use.
The rationale behind the idea is described [in this article](http://hkupty.github.io/2016/Ditching-TMUX/).
Consider helping by opening issues, Pull Requests or influencing your friends and colleagues to use!
