[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# BINS

The `Bins` class divides numeric data into `Range`s. Each data item can be an any object from which
we can extract an `x` value and (optionally) a `y` value (where `x,y` are selector
functions we can customise).

## Set up

    src               = process.env.PWD + "/../src/"
    {say,O}           = require src+ 'our'
    {Num,same,cliffs} = require src + 'num'
    {Sym}             = require src + 'sym'

## Range class

`Range`s are either numeric or symbolic, denoted `Nums` and `Syms`.
Each range is a pair  of `<seen,has>` where
`seen` are the values in that range and `has` is a summary `Num` or `Sym`
object for that range.

    class Range
      constructor: (inits=[],@has=@ako()) -> @seen= []; @adds inits
      adds:        (data=[])              -> (@add x for x in data); this
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

Ranking items

    sk = (lst, rank=0) ->
      rx0 = (rx) ->
        [txt,data...] = rx
        n = (new Nums).adds data
        n.txt = txt
        n
      leftRight = (lo,mid,hi) ->
        [left,right] = [new Nums, new Nums]
        (left.adds  rxs[i].seen for i in [lo..mid]  )
        (right.adds rxs[i].seen for i in [mid+1..hi])
        [left,right]
      xpect = (b4,x,y) ->
        x.n/b4.n * (b4.mu - x.mu)**2 + y.n/b4.n * (b4.mu - y.mu)**2
      split = (lo,hi,    cut=null,best=0) ->
        say "spkitting",lo,hi
        if lo < hi 
          b4 = new Nums
          (b4.adds rxs[j].seen for j in [lo..hi])
          for j in [lo..hi]
            if   j  < hi 
              [l,r] = leftRight(lo,j,hi)
              now = xpect(b4.has,l.has, r.has)
              say lo,j,hi,now,best,l.has,r.has
              if now > best and not same(l.seen, r.seen)
                [best,cut] = [now,j]
        say "cut", lo,cut,hi
        if cut  isnt null
          say "cutting"
          split(lo,   cut)
          split(cut+1, hi)
        else
          rank++
          say "other", j,rank
          (rxs[k].rank = rank for k in [lo..hi])
      rxs = (rx0(x) for x in lst)
               .sort (a,b) -> a.has.mu - b.has.mu
      split(0, rxs.length-1)
      rxs

## End stuff

    @Bins = Bins
    @sk = sk
