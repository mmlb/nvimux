nvimux = {}

-- [ Private variables and tables
local nvim = vim.api
local consts = {
  terminal_quit = '<C-\\><C-n>',
  esc = '<ESC>',
}

local fns = {}
local nvim_proxy = {
  __index = function(table, key)
    key_ = 'nvimux_' .. key
    val = nil
    if fns.exists(key_) then
      val = nvim.nvim_get_var(key_)
      table[key] = val
    end
    return val
  end
}

local vars = {
  prefix = '<C-b>',
  vertical_split = ':NvimuxVerticalSplit<CR>',
  horizontal_split = ':NvimuxHorizontalSplit<CR>',
  quickterm_provider = "call s:nvimux_new_toggle_term()",
  quickterm_scope = 'g',
  quickterm_direction = 'botright',
  quickterm_orientation = 'vertical',
  quickterm_size = '',
  new_term = 'term',
  close_term = 'x'
}

vars.split_type = function(t)
  return t.quickterm_direction .. ' ' .. t.quickterm_orientation .. ' ' .. t.quickterm_size .. 'split'
end


local defaults = {unpack(vars)}

setmetatable(vars, nvim_proxy)

-- ]

-- [ Private functions
-- [[ keybind commands
local function bind_fn(options)
  prefix = options.prefix  or ''
  mode = options.mode
  return function(key, command)
    suffix = string.sub(command, 1, 1) == ':' and '<CR>' or ''
    nvim.nvim_command(mode .. 'noremap <silent>' .. vars.prefix .. key .. ' ' .. prefix .. command .. suffix)
  end
end

fns.bind = {
  t = bind_fn{mode = 't', prefix = consts.terminal_quit},
  i = bind_fn{mode = 'i', prefix = consts.esc},
  n = bind_fn{mode = 'n'},
  v = bind_fn{mode = 'v'}
}

fns.bind._ = function(key, mapping, modes)
  for _, mode in ipairs(modes) do
    fns.bind[mode](key, mapping)
  end
end
-- ]]

-- [[ Commands and helper functions
fns.exists = function(var)
  return nvim.nvim_call_function('exists', {var}) == 1
end
fns.defn = function (var, val)
  if fns.exists(var) then
    nvim.nvim_set_var(var, val)
    return val
  else
    return nvim.nvim_get_var(var)
  end
end

fns.term_only = function(cmd)
  if nvim.nvim_buf_get_option('%', 'buftype') == 'terminal' then
    nvim.nvim_command(cmd)
  else
    print("Not on terminal")
  end
end
-- ]]
-- ]

-- [ Runtime and warmup
for key, cmd in pairs(defaults) do
  if type(cmd) == "string" then
    vars[key] = fns.defn('nvimux_' .. key, cmd)
  end
end
-- ]

-- [ Public API
-- [[ Public, but non-preferred
nvimux._reset = function()
  for key, value in pairs(defaults) do
    nvimux.config.set(key, value)
  end
end

nvimux._refresh = function()
  for key, _ in pairs(vars) do
    vars[key] = nvim.nvim_get_var('nvimux_' .. key)
  end
end
-- ]]

-- [[ Config-handling commands
nvimux.config = {}
nvimux.config.values = {}
setmetatable(nvimux.config.values, nvim_proxy)

nvimux.config.set = function(options)
  vars[options.key] = options.value
  nvim.nvim_set_var('nvimux_' .. options.key, options.value)
end
-- ]]

-- [[ Quickterm
nvimux.term = {}
nvimux.term.new_toggle = function()
  split_type = vars:split_type()
  nvim.nvim_command(split_type .. ' | enew | ' .. vars.new_term)
  buf_nr = nvim.nvim_call_function('bufnr', {'%'})
  nvim.nvim_buf_set_var(buf_nr, 'nvimux_buf_orientation', split_type)
  -- TODO Allow quickterm_scope
  nvimux.config.set{key = 'last_buffer_id', value = buf_nr}
end

nvimux.term.toggle = function()
  -- TODO Allow external commands
  if vars.last_buffer_id == nil then
    nvimux.term.new_toggle()
  else
    buf_nr = vars.last_buffer_id
    window = nvim.nvim_call_function('bufwinnr', {buf_nr})
    if window == -1 then
      if nvim.nvim_call_function('bufname', {buf_nr}) == '' then
        nvimux.term.new_toggle()
      else
        split_type = nvim.nvim_buf_get_var(buf_nr, 'nvimux_buf_orientation')
        nvim.nvim_command(split_type .. ' | b' .. buf_nr)
      end
    else
      nvim.nvim_command(window .. ' wincmd w | q | stopinsert')
    end
  end

end
-- ]]

-- [[ Top-level commands
nvimux.bind = function(options)
  if fns.exists('nvimux_override_' .. options.key) then
    options.key = nvim.nvim_get_var('nvimux_override_' .. var)
  end
  fns.bind._(options.key, options.value, options.modes)
end

 -- ]]
-- ]
