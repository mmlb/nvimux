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
In this case, opening a blank screen moves to `<prefix>-t`.

Terminal Provider
-----------------

If you have `neoterm` installed, it will be used by default.
If you want `nvimux` to use `neoterm`, make sure `neoterm` is loaded before `nvimux`.

You can opt to use vim's plain terminal instead of `neoterm`.
Just`let g:nvimux_no_neoterm = 1` and `neoterm` won't be used anymore. This is the same
behavior you get if you don't have neoterm installed.

###Defining quickterm position

You can set specific values for orientation, direction and size with the variables below:

```vim
"This are the defaults
let g:nvimux_toggle_direction = 'botright'
let g:nvimux_toggle_orientation = 'vertical'
let g:nvimux_toggle_size = ''
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
