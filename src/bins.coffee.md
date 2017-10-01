[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# BINS

The `Bins` class divides numeric data into `Range`s. Each data item can be an any object from which
we can extract an `x` value and (optionally) a `y` value (where `x,y` are selector
functions we can customise).

## Set up

    requires = (f) -> 
      require(process.env.PWD + "/" + f + '.coffee.md')

    the = requires 'our'
    say = the.say
    Num   = requires('num').Num
    Sym   = requires('sym').Sym

## Range class

`Range`s are either numeric or symbolic, denoted `Nums` and `Syms`.
Each range is a pair  of `<seen,has>` where
`seen` are the values in that range and `has` is a summary `Num` or `Sym`
object for that range.

    class Range
      constructor: (inits=[],@has=@ako()) -> @seen= []; @adds inits
      adds:        (data=[])              -> (@add x for x in data)
      add:         (x)                    -> @seen.push (@has.add x)
      xpect:       (n=1)                  -> @has.n/n * @impurity()
      clone:       (inits=[])  ->
        x= new @constructor(@seen,@ako())
        x.adds inits
        x

All `Ranges`s can report their `impurity`
which is either standard deviation or entropy for `Nums` or `Syms` respectively.

    class Nums extends Range
      ako:      -> new Num
      impurity: -> @has.sd

    class Syms extends Range
      ako:      -> new Sym
      impurity: -> @has.ent()

## Bins Class

`Bins` divides data into a small number of divisions.  The `xranges`
found by these code use some `x` value taken from each item in
`data`.  Optionally, each data item may also include a `y` value
in which case the `yranges` are a subset of the `xranges`, where
any xrange that does not change the `y` value are discarded.

    class Bins
      constructor: (@data=[], o=[]) ->
        #-------------------
        # set config options 
        @x     = o.x     or ((z) => z[0]) # where to find the `x` values
        @y     = o.y     or ((z) => z[1]) # where to find the `y` values
        @no    = o.no    or "?"           # what marks missing values
        @nump  = o.nump  or true          # are the `y` values Nums or Syms?
        cohen  = o.cohen or 0.2           # if epsilon missing, use (say) 20% of the sd
        some   = o.some  or 128           # if epsilon missing, compute it from (say) 128 items
        nsize  = o.nsize or 0.5           # if enough missing, use portion of the list length
        # ranges must have enough items
        enough = o.enough  or ((data) => data.length**nsize)
        # (hi - lo) in ranges must be over epsilon
        epsilon= o.epsilon or ((data,x) => ((new Num).adds data[1..some], x).sd*cohen)
        #--------------------
        # intiailizations
        [ @e, @min ] = [ epsilon(@data,@x), enough @data ]

Here's how to sort data, being mindful on missing values

      order: (data) ->
        data.sort (z1,z2) =>
          [x1, x2] = [@x(z1), @x(z2)]
          return 0 if x1 is @no
          return 0 if x2 is @no
          return x1 - x2

We can return a range when it is `full` of enough values (ranging
over more than epsilon `e`)...

      full: (xs) ->
        xs.has.hi - xs.has.lo > @e and xs.has.n > @min

...and when, to the right, there is space for at elast one more range.

      room2right: (xs,j, xlast) ->
        xlast - xs.has.hi > @e and @data.length - j > @min

When walking over the ranges, we track the `x` numbers and, for the
`y` values, either numbers or symbols.

      next: ->
        [new Nums, new (if @nump then Nums else Syms)]

An `xrange` is the first set of numbers that satisfy `fill` and
`room4More`.

      xrange: (b4)  ->
        @data = [..., last] = @order( @data )
        [xs, ys] = @next()
        for z,j in @data
          [x, y] = [@x(z), @y(z)]
          if @full(xs) and @room2right(xs,j, @x(last)) and x > b4
            yield [xs,ys]
            [xs, ys] = @next()
          xs.add x; ys.add y
          b4 = x
        yield [xs,ys]

A `yrange` are the `xrange`s but after merging any adjacent ranges where the `y`
value stays.

      yrange: (b4) ->
        [xs1, ys1] = @next()
        for [xs2,ys2] from @xrange()
          ys12 = ys1.clone(ys2.seen)
          n = ys12.has.n
          if ys1.xpect(n) + ys2.xpect(n) < ys12.xpect()
             yield [xs1,ys1]
             [xs1,ys1] = [xs2,ys2]
          else
            xs1.adds xs2.seen
            ys1=ys12
        if xs1.has.n
          yield [xs1,ys1]

## End stuff

    if require.main == module
        Rand  = require('./rand').Rand
        r= new Rand(1)
        pair = () ->
          x = r.next()**2
          x = Math.floor(x * 100)
          switch
            when x < 20 then  [x,10]
            when x < 60 then  [x,40]
            else [x,80]
        pairs= (pair()  for x in [0..10000]) 
        b= new Bins(pairs)
        for [x,y] from b.xrange()
          say "unper>",x.has.n,x.has.lo,x.has.hi ,y.has.lo,y.has.hi
        say ""
        for [x,y] from b.yrange()
          say "super>",x.has.n,x.has.lo,x.has.hi,y.has.lo,y.has.hi
