[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# NUM

Incremental collector of `lo,hi` and `sd` (standard deviation) of
a stream of numbers. Also, implements some parametric
hypothesis and effect size tests.       

## Examples

    eg1 = ->
      n = new Num
      (n.add x for x in [9,2,5,4,12,7,8,11,9,3,7,4,12,5,4,10,9,6,9,4])
      the.say n.mu

    eg2 = ->
      n = new Num
      n.adds [9,2,5,4,12,7,8,11,9,3,7,4,12,5,4,10,9,6,9,4], (x) -> 0.1*x
      the.say n.mu,n.sd

    eg3 ->
		 Rand=(requre my+'rand').Rand
		 r=new Rand(1)
		 [n1,n2] = [new Num, new Num]
		 for i in [1..20]
		    s = r()
				n1.add i
				n2.add i + s/10
     		 
## Code

All the methods marked as `_xxx` extends functionality of the `xxx`
methods defined in the [Col](col.coffee.md) superclass.

    my  = process.env.PWD + "/" 
    the = require my+'our'
    Col = require(my+'col').Col

    class Num extends Col
      constructor: (args...) ->
        super args...
        [ @mu,@m2,@sd ] = [ 0,0,0,0 ]
        [ @hi, @lo ]    = [ the.ninf, the.inf ]

**_add a value to this collector**.
Uses [Welford's incremental sd
algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Online_algorithm) to update standard deviation.
(thus avoiding the "catastrophic cancellation of precision" seen
with other methods).

      add1: (x) ->
        @lo = if x < @lo then x else @lo
        @hi = if x > @hi then x else @hi
        delta = x - @mu
        @mu += delta / @n
        @m2 += delta * (x - @mu)
        if @n > 1 then @sd = (@m2 / (@n - 1))**0.5

**_normalize a number**  `x` into the range `0..1`, `lo..hi`.

      norm1: (x) ->
        (x - @lo) / (@hi - @lo +  _.tiny)

**Print** contents.

      toString: ->
         " #{@n}:#{@lo}..#{@hi}"

**tTestThreshold** Low-level stuff. Implements look-up table on the
standard t-test critical values table.

      @first:  3
      @last:  96
      @crit:
        95: {3:3.182, 6:2.447, 12:2.179, 24:2.064, 48:2.011, 96:1.985}
        99: {3:5.841, 6:3.707, 12:3.055, 24:2.797, 48:2.682, 96:2.625}
      ttest1: (x, a=Num.crit[Num.cert] ) ->
        y = (i) ->
          j = i*2
          if x in [i..j] then a[i] + (a[j]-a[i]) * (x-i) / (j-i) else y(j)
        switch
          when x <= Num.first then a[ Num.first ]
          when x >= Num.last  then a[ Num.last  ]
          else y(Num.first)

      max = (x,y) -> if x > y then x else y
      abs = (x,y) ->  if x >= 0 then x else -1*x

      ttest= (i,j) ->
        #  Debugged using https://goo.gl/CRl1Bz
        t  = (i.mu - j.mu) / max(10**-64, i.sd**2/i.n + j.sd**2/j.n)**0.5
        a  = i.sd**2/i.n
        b  = j.sd**2/j.n
        df = (a + b)**2 / (10**-64 + a**2/(i.n-1) + b**2/(j.n - 1))
        abs(t) > @ttest1(df)

      hedges= (i,j) ->
        # https://goo.gl/w62iIL
        nom   = (i.n - 1)*i.sd**2 + (j.n - 1)*j.sd^2
        denom = (i.n - 1)        + (j.n - 1)
        sp    = ( nom / denom )**0.5
        g     = abs(i.mu - j.mu) / sp
        c     = 1 - 3.0 / (4*(i.n + j.n - 2) - 1)
        g * c > the.num.small  ## what to put here?

## End stuff

    @Num = Num
    if require.main == module
      eg1()
      eg2()
			eg3()
