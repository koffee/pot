[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# ARGS


      args= (settings,ignore,updates=process.argv) ->
         for flag,i in updates
           
return function (settings,ignore, updates)
  updates = updates or arg
  -- Usually, read all the args.
  ignore = ignore or {}
  local i = 1
  while updates[i] ~= nil  do
    local flag = updates[i]
    local b4   = #flag
    flag = flag:gsub("^[-]+","")
    if not member(flag,ignore) then
      -- Complain if no old value to override
      if settings[flag] == nil then
        error("unknown flag '" .. flag .. "'")
      else
        -- If no arg to this flag, then set a boolean.
        if b4 - #flag == 2 then
          settings[flag] = true
        -- If there is an arg then....
        elseif b4 - #flag == 1 then
          local a1 = updates[i+1]
          local a2 = tonumber(a1)
          -- Set either a number of a string
          settings[flag] = a2  or a1
          i = i + 1 
    end end end
    i = i + 1
  end
