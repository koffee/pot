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

    bins = (lst,opt=[]) ->
      # defaults
      opt.no      ?= "?"
      opt.nump    ?= true
      opt.cohen   ?= 0.2
      opt.nsize   ?= 0.5
      opt.some    ?= 128
      opt.x       ?= (z) -> z[0]
      opt.y       ?= (z) -> z[1]
      opt.enough  ?= (lst) -> lst.length**opt.nsize
      opt.epsilon ?= (lst) ->
                       n = new Num
                       n.adds lst[1..opt.some], opt.x
                       n.sd*opt.cohen
      impurity = (z) -> if opt.nump then z.sd else z.ent()
      # sort order
      order = (z1,z2) ->
        [x1, x2] = [opt.x(z1), opt.x(z2)]
        console.log
             z1: z1
             z2: z2
             x: x1
             y: x2
             zz: x1 - x2
        if x1 is opt.no or x2 is opt.no
            1
        else
            x1 - x2
      # create a pair of collectors for x,y
      next = ->
        [xs, ys] = [new Num, new if opt.nump then Num else Sym]
        [xs.seen, ys.seen] = [[], []]
        [xs,ys]
      # add an item to our pairs of collectors
      now = (x,y, xs, ys) ->
        (xs.add x; xs.seen.push x) if opt.y
        (ys.add y; ys.seen.push y) if opt.y
        [x,y]
      # step thru the lst, yeilding one range at a time
      bin = (lst, most, epsilon, enough, b4)  ->
        [xs, ys,] = next()
        for z,j in lst
          [x, y] = [opt.x(z), opt.y(z)]
          if   xs.hi - xs.lo > epsilon and xs.n           > enough  # space here
            if most - xs.hi > epsilon  and lst.length - j > enough # space right
              if x > b4 # different
                yield [xs,ys]
                [xs, ys] = next()
          now(x,y, xs, ys)
          b4 = x
        yield [xs,ys]
      # step thru the lst, yeilding one range at a time
      last= null
      [xs,ys]  = next()
      console.log lst.sort(order)
#      for [xs1,ys1] from bin(order lst,
#                             opt.x lst.last(),
#                             opt.epsilon(lst),
#                             opt.enough(lst))
#        tmp = ys.adds ys1.seen
#        if impurity(tmp,tp.n) > i
#
## End stuff

    if require.main == module
       r= new Rand
       #bins (x for x in [0..20]), opt
       lst = [ [10,2],["?",4],[3,4],[-2,3], [5,6], ["?",20]]
       bins lst # ([x,Math.floor(x/4)] for x in [0..20])
