[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

todo: is out[b] wrong? need another method

simple

    the = require 'our'
    say = the.say
    Num   = require('num').Num
    Sym   = require('num').Sym
    Rand  = require('rand').Rand
 
    bins = (lst,opt) ->
      # defaults
      opt.nump    ?= true
      opt.cohen   ?= 0.2
      opt.nsize   ?= 0.5
      opt.some    ?= 128
      opt.x       ?= (z) -> z[0]
      opt.y       ?= (z) -> z[1]
      opt.enough  ?= (lst) -> lst.length**opt.nsize
      opt.epsilon ?= (lst) ->
                     ((new Num).adds lst[1..opt.same], opt.x).sd*opt.cohen
      impurity = (z) -> if opt.nump then z.sd else z.ent()
      # sort order
      order = (lst) ->
        lst.sort (z1,z2) ->
          [x1, x2] = [opt.x(z1), opt.x(z2)]
          return 0 if x1 is opt.no
          return 0 if x2 is opt.no
          return x1 - x2
      # create a pair of collectors for x,y 
      next = ->
        [xs, ys] = [new Num, if opt.nump then new Num else new Sym]
        [xs.seen, ys.seen] = [[], []]
        [xs,ys]
      # add an item to our pairs of collectors
      now = (z, xs, ys) ->
        [x, y] = [opt.x(z), opt.y(z)]
        xs.add x; xs.seen.push x
        ys.add y; ys.seen.push y
        [x,y]
      # step thru the lst, yeilding one range at a time
      bin = (epsilon,enough, b4)  ->
        [xs, ys,] = next()
        lst  = order lst
        most = opt.x lst.last()
        for z,j in lst
          [x, y] = now(z, xs, ys)
          if xs.hi - xs.lo > epsilon and xs.n > enough  # space here
            if lst.length - j > enough and most - xs.hi > epsilon # space right
              if x > b4 and # different
                 yield [xs,ys]
                [xs, ys] = next()
          b4 = x
        yield [xs,ys]
      # step thru the lst, yeilding one range at a time
      last= null
      [xs0,ys0]  = []
      for [xs,ys] from bin( opt.epsilon(lst),
                            opt.enough(lst))
        console.log 1000, xs.lo, xs.hi

## End stuff

    if require.main == module
       r= new Rand
       opt=
         x:  (z) -> z
         y:  (z) -> z
       bins (x for x in [0..20]), opt

