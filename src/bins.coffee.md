[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

todo: is out[b] wrong? need another methodz xxx

simple

    the = require './our'
    say = the.say
    Num   = require('./num').Num
    Sym   = require('./num').Sym
    Rand  = require('./rand').Rand

`Sample`s are a set of things. Anything added to a sample is summarized
as either a `Num` or a `Sym`, then added to a list of `seen` things.

    class Sample
      constructor: (inits=[],@has=@ako()) -> @adds inits
      adds:        (lst=[])               -> (@add x for x in lst)
      add:         (x)                    -> @seen.push (@has.add x)
      xpect:       (n=1)                  -> @has.n/n * @impurity()
      clone:       (items=@seen)          -> @constructor items,@ako()

All `Sample`s can report their `impurity`
which is either standard deviaon or entropy for `Nums` or `Syms` respectively.

    class Nums extends Sample
      ako:      -> Num()
      impurity: -> @has.sd

    class Syms extends Sample
      ako:      -> Sym()
      impurity: -> @has.ent()

`Bins` divides data into a small number of divisions.

- The `xranges` found by these code use some `x` value taken from each item in `data`.
- Optionally, each item of lst may also include a `y` value in which case the 

    class Bins
      constructor: (data,o=[]) ->
        @x     = o.x       or (z) -> z[0]
        @y     = o.y       or (z) -> z[1]
        @no    = o.no      or "?"
        @nump  = o.nump    or true
        cohen  = o.cohen   or 0.2
        some   = o.some    or 128
        nsize  = o.nsize   or 0.5
        enough = o.enough  or (data) -> data.length**opt.nsize
        epsilon= o.epsilon or (data) -> new Num
                                        .adds data[1..some], @x
                                        .sd*opt.cohen
        @data = data.sort(@order)
        [..., @last] = @data
        @e   = epsilon(data)
        @min = enough(data)
      order: (data) ->
        data.sort (z1,z2) ->
          [x1, x2] = [@x(z1), @x(z2)]
          return 0 if x1 is @no
          return 0 if x2 is @no
          return x1 - x2
      full: (xs) ->
        xs.has.h1 - xs.has.lo > @e and xs.has.n > @min
      room4More: (xs,j) ->
        @x(@last) - xs.has.hi > @e and @data.length -j > @min
      next: ->
        [Nums(), if @nump then Nums() else Syms()]
      xrange: (b4)  ->
        [xs, ys] = @next()
        for z,j in @data
          [x, y] = [@x(z), @y(z)]
          if @full(xs) and @room4More(xs,j) and x > b4 
            yield [xs,ys]
            [xs, ys] = @next()
          xs.add x; ys.add y
          b4 = x
        yield [xs,ys]
      # step thru the data, yeilding one range at a time
#      yrange: (b4, all=[]) ->
#        [xNum1, yNum1] = [new Num, @yThing()]
#        for [xnum,xall,yall] from @xrange()
#          yNum2 = @yThing(yall) # local n
#          yNum0 = clone ys0
#          yNum0.adds yall       # now aand before
#          n = ys2.n
#          if impurity(yNum1, n) + impurirty(yNum2, n) < impurity(yNum0, n)
#            Lw

## End stuff

    if require.main == module
        console.log 1
#       r= new Rand
#       #bins (x for x in [0..20]), opt
#       bins ([x,Math.floor(x/4)] for x in [0..20])
