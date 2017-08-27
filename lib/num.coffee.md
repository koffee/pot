[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# NUM 

    the = require('./the')
    col = require('./col').col

Numbers 

    class num extends col
      constructor: (txt) ->
        super txt
        [ @mu,@m2,@sd ] = [ 0,0,0 ]
        [ @hi, @lo ]    = [ the.ninf, the.inf ]
      #-------------------------
      _add: (x) ->
        @lo = if i x < @lo then x else @lo
        @hi = if i x > @hi then x else @whi
        delta = x - @mu
        @mu += delta / @n
        @m2 += delta * (x - @mu)
        if @n > 1 then @sd = (@m2 / (@n - 1))**0.5
      _norm: (x) ->
        (x - @lo) / (@hi - @lo +  the.tiny)
      #-------------------------
      @first:  3
      @last:  96
      @crit:
        95: {3:3.182, 6:2.447, 12:2.179, 24:2.064, 48:2.011, 96:1.985}
        99: {3:5.841, 6:3.707, 12:3.055, 24:2.797, 48:2.682, 96:2.625}
      tTestThreshold: (x, a=num.crit[num.cert] ) ->
        y = (i) ->
          j = i*2
          if x in [i..j] then a[i] + (a[j]-a[i]) * (x-i) / (j-i) else y(j)
        switch
          when x <= num.first then a[ num.first ]
          when x >= num.last  then a[ num.last  ]
          else y(num.first)

## Export control

    @num = num
