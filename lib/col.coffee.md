[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# COL

Abstract superclass for [`num`](num.coffee.md) and [`sym`](sym.coffee.md).  
Implements some `mixin` behaviours where common patterns in 
method `xxx` is handled by subclass methods `_xxx`.

     the = require("./the")

All [`col`]s have:

- `@n`: number of items seen;   
- `@w`: a weight of 1 (and some cols will be -1 if, eg., they are goals to minimize);
- `@txt`: a text name.

:
     class @col
       constructor: (txt) ->
         @n   = 0
         @w   = 1
         @txt = txt

Only add things that should not be `ignore`d.

       add: (x) ->
         if x isnt the.ignore 
           @n++
           @_add x
         x

Add many things, mabye filtering them through the `f` function.

       adds: (a,f) ->
         f= f or (x) -> x
         (add(f(x)) for x in a)

Normalize things, unless they are things to be `ignored`.

       norm: (x) ->
         if x isnt the.ignore then @_norm x else x

## Export control

    this.col = col

