[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# Unsupervised  discretizer

    the = require 'our'
    say = the.say
    Range = require('range').Range
    Num   = require('num').Num
    Rand  = require('rand').Rand

    ranges = (lst0,
              x      = (z) -> z,
              cohen  = 0.2,
              nsize  = 0.5,
              enough = (num) -> num.n**nsize,
              epsilon= (num) -> num.sd*cohen) ->
      [all, out, lst, last] = [new Num, [], []]
      for a0 in lst0
        a = x(a0)
        if a isnt the.ignore
          all.add a
          lst.push a
      [e, nough] = [epsilon(all), enough(all)]
      r = new Num
                      # _____above______  and ____below_____
      enoughs  = (j) -> j < all.n - nough and r.n > nough
      epsilons = (a) -> a + e < all.hi    and r.hi - r.lo > e
      for a,j in lst.sort((x,y) -> x - y)
        if enoughs(j) and epsilons(a) and a > last
          out.push r
          r = new Num
        r.add a
        last = a
      return out

    superRanges = (lst0,
                   x      = (z) -> z[0],
                   y      = (z) -> z[1],
                   nump   = true,
                   cohen  = 0.2,
                   nsize  = 0.5,
                   enough = (num) -> num.n**nsize,
                   epsilon= (num) -> num.sd*cohen) ->
      unsup = ranges(lst0,x, cohen, nsize, enough, epsilon)
      

## End stuff

    @ranges = ranges
    @Range  = Range
    if require.main == module
      r   = new Rand
      lst = for i in [1 .. 64*64]
              Math.round(100*r.next()**0.5) 
      (say r for r in ranges(lst))
