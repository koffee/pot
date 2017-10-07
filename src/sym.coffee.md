[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# SYM 

Standard usage

    egSym = ->
      s= new Sym
      s.adds ['a','b','b','c','c','c','c']
      console.log "egSym:",s.n, s.counts, s.ent().toFixed(3)
      O.want  s.ent().toFixed(3) == '1.379'

Set up:

    src   = process.env.PWD + "/../src/"
    {say,assert,O,memo} = require src+'our'
    {Col} = require src+'col'

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
      #-------------------------
      ent: (e=0)->
        if @_ent == null
          for x,y of @counts
            p  = y/@n
            e -= p*Math.log2(p)
          @_ent = e
        @_ent
      #-------------------------
      norm1: (x) -> x

## Export control

    @Sym = Sym
    @tests=[egSym]
