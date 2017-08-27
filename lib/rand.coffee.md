[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.png>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# RANDOM

Knuth and Lewis' improvements to Park and Miller's LCPRNG
if created without a seed, uses current time as seed

    class rand
      @seed0: 10013
      @mult:  16807
      @mod:   2147483647
      constructor: (n = rand.seed0) ->
        @reset(n)
      #--------------------
      reset: (n) ->
        @some = null
        @seed = n % rand.mod
      #--------------------
      fromOS: () ->
        d= new Date()
        @reset( (d.valueOf() * d.getMilliseconds()))
      #--------------------
      one: () ->
        @seed = (rand.mult * @seed) % rand.mod
        @seed / rand.mod
      #--------------------
      next: () ->
        @some = @some or (@one() for [1..97])
        x = @one()
        i = Math.floor 97*x
        [ x,@some[i] ] = [ @some[i],x ]
        x

    this.rand = rand

