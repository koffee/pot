[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# SYM 

    the = require('./the')
    col = require('./col').col

asdassdsaasdasasdsassasa

    class sym extends col
      constructor: (txt) ->
        super txt
        [ @counts,@most,@mode ] = [ [],0,null ]
      #-------------------------
      _add: (x) ->
        if not x in @counts then @counts[x] = 0
        seen = ++@counts[x]
        if seen > @most then
          [ @most,@mode ] = [ seen,x ] 
      #-------------------------
      _norm: (x) -> x

## Export control

    @sym = sym
