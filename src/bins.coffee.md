[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

todo: is out[b] wrong? need another method

simple    

    the = require './our'
    say = the.say
    Num   = require('./num').Num
    Sym   = require('./num').Sym
    Rand  = require('./rand').Rand

`Sample`s keep track of `things` which can be `Num`s or `Sym`s.

    class Sample
      constructor: (@contents=[],@what=Num) ->
        @things = @what()
        @seen   = []
        @adds @contents
      adds    : (lst=[]) ->
        (@add x for x in lst)
      xpect: (n=1)  ->
        @things.n/n * @impurity()
      clone   : (using=@seen) ->
        Sample(using,@what)
      add     : (thing)  ->
        @seen.add thing
        @things.add thing

Regardless of the `thing` type, all `Sample`s can report their `impurity`
(standard)

    class Nums extends Sample
      constructor(contents) -> super contents,Sym
      impurity: -> @things.sd

    class Syms extends Sample
      constructor(contents) -> super contents,Sym
      impurity: -> @things.ent()


    class bins
      constructor: (lst,o=[]) ->
        @x     = o.x       or (z) -> z[0]
        @y     = o.y       or (z) -> z[1]
        @no    = o.no      or "?",
        @nump  = o.true    or true,
        cohen  = o.cohen   or 0.2,
        some   = o.some    or 128
        nsize  = o.nsize   or 0.5
        enough = o.enough  or (lst) -> lst.length**opt.nsize
        epsilon= o.epsilon or (lst) -> n = new Num
                                       n.adds lst[1..some], opt.x
                                       n.sd*opt.cohen
        @lst   = lst.sort(@order)
        @e     = epsilon(lst)
        @min   = enough(lst)
      impurity: (z,n) ->
        z.n/n * if @nump then z.sd else z.ent()
      order: (lst) ->
        lst.sort (z1,z2) ->
          [x1, x2] = [@x(z1), @x(z2)]
          return 0 if x1 is @no
          return 0 if x2 is @no
          return x1 - x2
      next: ->
         [new Num, [],[]]
      now:  (x,y,xnum, xall, yall) ->
        xnum.add  x
        yall.push y
        xall.push x
        [x,y]
      ranges: ->
        for [xnum,xall,yall] from @xrange()
          yield xnum
      xrange: (b4)  ->
        [xnum, xall, yall] = @next()
        for z,j in @lst
          [x, y] = [@x(z), @y(z)]
          if   @e < xnum.hi - xnum.lo and @min < xnum.n  # space here
            if @e < most - xnum.hi and @min < lst.length - j # space right
              if x > b4 # different
                yield [xnum,yall]
                [xnum, xall, yall] = @next()
          @now(x,y, xnum, xall, yall)
          b4 = x
        yield [xnum,yall]
      # step thru the lst, yeilding one range at a time
      yrange: (b4, all=[]) ->
        [xNum1, yNum1] = [new Num, @yThing()]
        for [xnum,xall,yall] from @xrange()
          yNum2 = @yThing(yall) # local n
          yNum0 = clone ys0
          yNum0.adds yall       # now aand before
          n = ys2.n
          if impurity(yNum1, n) + impurirty(yNum2, n) < impurity(yNum0, n)
            Lw

      yThing: (lst[]) ->
        out = new if @nump then Num else Sym
        out.add lst
        out

## End stuff

    if require.main == module
       r= new Rand
       #bins (x for x in [0..20]), opt
       bins ([x,Math.floor(x/4)] for x in [0..20])
