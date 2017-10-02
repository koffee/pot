[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# SYM 

    my  = process.env.PWD + "/" 
    the = require my+'our'
    Col = require(my+'col').Col

asdassdsaasdasasdsassasa

    class Sym extends Col
      constructor: (args...) ->
        super args...
        [ @counts,@most,@mode,@_ent ] = [ [],0,null,null ]
      #-------------------------
      add1: (x) ->
        @_ent = null
        @counts[x] = 0 unless @counts[x]
        seen = ++@counts[x]
        [ @most,@mode ] = [ seen,x ] if seen > @most
      ent: ->
        for x in @counts
          p = x/@n
          e -= Math
      #-------------------------
      norm1: (x) -> x

## Export control

    @Sym = Sym
