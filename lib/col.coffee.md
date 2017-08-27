[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# COL

     the = require("./the")

     class @col
       constructor: (txt) ->
         @n   = 0
         @w   = 1
         @txt = txt
       add: (x) ->
         if x isnt the.ignore 
           @n++
           @_add x
         x
       adds: (a,f) ->
         f= f or (x) -> x
         (add(f(x)) for x in a)
       norm: (x) ->
         if x isnt the.ignore then @_norm x else x
