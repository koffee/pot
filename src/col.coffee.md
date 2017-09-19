[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# COL

Abstract superclass for [`num`](num.coffee.md) and [`sym`](sym.coffee.md).
Implements some _mixin_ behaviours where common patterns in
method `xxx` is handled by subclass methods `xxx1`.

    the = require "our"
    class Col

All [`Col`]s have:

- `@n`: number of items seen;
- `@w`: a weight of 1 (and some Cols will be -1 if, eg., they are goals to minimize);
- `@txt`: a text name.

as defined below by the following constructor:

      constructor: (txt,w,pos) ->
         @n   = 0
         @w   = w or 1
         @pos = pos
         @txt = txt

Only add things that should not be `ignore`d.

      add: (x) ->
         if x isnt the.ignore
           @n++
           @add1 x
         x

Add many things, mabye filtering them through the `f` function.

      adds: (a,f) ->
         f = f or (x) -> x  # the default `f` is "do nothing"
         (@add(f(x)) for x in a)
         this

Normalize things, unless they are things to be `ignored`.

      norm: (x) ->
         if x isnt the.ignore then @norm1 x else x

## Export control

    @Col = Col

