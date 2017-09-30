[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# BINS

Divide up numbers in some data

## Set up

    the = require './our'
    say = the.say
    Num   = require('./num').Num
    Sym   = require('./num').Sym
    Rand  = require('./rand').Rand

## Bins Class

`Bins` divides data into a small number of divisions.  The `xranges`
found by these code use some `x` value taken from each item in
`data`.  Optionally, each data item may also include a `y` value
in which case the `yranges` are a subset of the `xranges`, where
any xrange that does not change the `y` values are discarded.

    class Bins
      constructor: (data,o=[]) ->
        #-------------------
        # set config options 
        @x     = o.x       or (z) -> z[0] # where to find the `x` values
        @y     = o.y       or (z) -> z[1] # where to find the `y` values
        @no    = o.no      or "?"         # what marks missing values
        @nump  = o.nump    or true        # are the `y` values Nums or Syms?
        cohen  = o.cohen   or 0.2         # if epsilon missing, use (say) 20% of the sd
        some   = o.some    or 128         # if epsilon missing, compute it from (say) 128 items
        nsize  = o.nsize   or 0.5         # if enough missing, use portion of the list length
        enough = o.enough  or (data) ->   # ranges must have enough items
           data.length**opt.nsize
        epsilon= o.epsilon or (data) ->   # (hi - lo) in ranges must be over epsilon
           ((new Num) adds data[1..some], @x).sd*opt.cohen
        #--------------------
        # intiailizations
        [ @e, @min ] = [ epsilon(), enough() ]

Here's how to sort data, being mindful on missing values

      order: (data) ->
        data.sort (z1,z2) ->
          [x1, x2] = [@x(z1), @x(z2)]
          return 0 if x1 is @no
          return 0 if x2 is @no
          return x1 - x2

We can return a range when it is `full` of enough values (ranging
over more than epsilon `e`)...

      full: (xs) ->
        xs.has.h1 - xs.has.lo > @e and xs.has.n > @min

...and when, to the right, there is space for at elast one more range.

      room4More: (xs,j,last) ->
        @x(last) - xs.has.hi > @e and @data.length - j > @min

When walking over the ranges, we track the `x` numbers and, for the
`y` values, either numbers or symbols.

      next: ->
        [Nums(), if @nump then Nums() else Syms()]

An `xrange` is the first set of numbers that satisfy `fill` and
`room4More`.

      xrange: (b4)  ->
        @data = [..., last] = @order( @data )
        [xs, ys] = @next()
        for z,j in @data
          [x, y] = [@x(z), @y(z)]
          if @full(xs) and @room4More(xs,j,last) and x > b4
            yield [xs,ys]
            [xs, ys] = @next()
          xs.add x; ys.add y
          b4 = x
        yield [xs,ys]

A `yrange` are the `xrange`s where the `y` values change significantly
from one range to another.

#      yrange: (b4, all=[]) ->
#        [xNum1, yNum1] = [new Num, @yThing()]
#        for [xnum,xall,yall] from @xrange()
#          yNum2 = @yThing(yall) # local n
#          yNum0 = clone ys0
#          yNum0.adds yall       # now aand before
#          n = ys2.n
#          if impurity(yNum1, n) + impurirty(yNum2, n) < impurity(yNum0, n)
#            Lw

## Sample Class

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

## End stuff

    if require.main == module
        console.log 1
#       r= new Rand
#       #bins (x for x in [0..20]), opt
#       bins ([x,Math.floor(x/4)] for x in [0..20])
