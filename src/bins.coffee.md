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
    Range = require('range').Range
    Num   = require('num').Num
    Sym   = require('num').Sym
    Rand  = require('rand').Rand

    order = (lst,opt) ->
      lst.sort (z1,z2) ->
        [x1, x2] = [opt.x(z1), opt.x(z2)]
        return 0 if x1 is opt.no
        return 0 if x2 is opt.no
        return x1 - x2

    next = (opt) ->
      [xs, ys] = [new Num, if opt.nump then Num else Sym]
      [xs.seen, ys.seen] = [[], []]
      [xs,ys]

    now = (z,opt) ->
      [x, y] = [opt.x(z), opt.y(z)]
      xs add x; xs.seen.push x
      ys add y; ys.seen.push y
      [x,y]

    some = (lst,opt,epsilon,enough)  ->
      last= null
      [xs, ys,] = next(opt)
      for z in order(lst)
        [x, y] = now(z,opt),
        if xs.hi - xs.lo > epsilon and xs.n > enough
          yield [xs,ys]
          [xs, ys] = next(opt)
        last = x

    reange = (lst,opt) ->
      opt.nump    ?= true
      opt.cohen   ?= 0.2
      opt.nsize   ?= 0.5
      opt.x       ?= (z) -> z[0]
      opt.y       ?= (z) -> z[1]
      opt.epsilon ?= (lst) -> ((new Num).adds lst[1..128], opt.x).sd*opt.cohen
      opt.enough  ?= (lst) -> lst.length**opt.nsize
      [xs0,ys0]  = []
      for [xs,ys] from some(lst,opt,epsilon(all), enough(all))
        if xs0  

    xRanges = (all, opt={}) ->
      # setting defaults
      opt.cohen   ?= 0.2
      opt.nsize   ?= 0.5
      opt.nump    ?= true
      opt.impurity?= (z) -> if opt.nump then z.sd else z.ent()
      opt.enough  ?= (num) -> all.length**opt.nsize
      opt.epsilon ?= (num) -> ((new Num).adds lst[1..128],x).sd*opt.cohen
      # ------------------------
      # useful shortcuts
      now     = -> tmp= new Num; tmp.seen=[]; tmp
      enoughs = (j)    -> r.n > nough     and j < all.n - nough
      large   = (xval) -> r.hi - r.lo > e and xval + e < all.hi
            # ------------------------
      # more initializations (that use pre-scan results)
      no    = "?"
      e     = opt.epsilon(all)
      nough = opt.enough(all)
      lst   = lst.sort order
      # scanning, push each item to a current range 'r' 
      xs = new Num
      ys = now()
      j = 0
      for one in lst.sort order
        x = opt.x(one)
        if isnt no
          j++
          y = opt.y(one)
          if enoughs(j) and large(xval) and  > last
            out.push r  # save old range
          r = now()   # start a new one
        r.add xval
        r.seen.push one
        last = xval
      # and done
      return out

ranges = xRanges(lst,opt)
yranges(ranges, opt)

    yRanges = (ranges, opt={}, out=[]) ->
       opt.x    ?= (z) -> z[0]
       opt.y    ?= (z) -> z[1]
       opt.nump ?=  true
       # shortcuts
       next   = ->     if opt.nump then new Num else new Sym
       purity = (z) -> if opt.nump then z.sd    else z.ent()
       # cache a frequent computation
       summarize  = (here, stop,   t) ->
         inc = if stop > here then 1 else -1
         if here isnt stop
           now = clone summarize(here+inc, stop, t)
         else
           now = next()
         t[here] = now.adds ranges[here].seen, opt.y
       # assign bins to ranges
       recurse = (all,lo=0, hi=all.length-1, b=0, lvl=0,cut,lhs={},rhs={}) ->
         best = purity(all)
         summarize(hi,lo,lhs)  # summarize i+1 using i
         summarize(lo,hi,rhs) # summarize i using i+1
         for j in [lo.. hi-1]
           [l,r] = [lhs[j], rhs[j+1]]
           tmp = l.n/all.n * purity(l) + r.n/all.n*purity(r)
           if tmp < best
             [cut,best] = [j,tmp]
         if cut
           b = 1 + recurse(lhs[cut],   lo,    cut, b, lvl+1)
           b =     recurse(rhs[cut+1], cut+1,  hi, b, lvl+1)
         else
           out[b] = ranges[hi].hi
         return b
       # get the ranges, then break them up
       recurse( summarize(0, ranges.length-1, {}) )
       out

## End stuff

    @ranges = ranges
    @Range  = Range
    if require.main == module
      r   = new Rand
      lst = for i in [1 .. 10**5]
              tmp=Math.round(100*r.next()**0.5)
              if tmp < 0.2 
                [tmp,0.2]
              else if tmp < 0.6 
                ptmp,0.6]
              else [tmp,0.2]
      opt= 
        x: (z) -> [0]
        y: (z) -> [1]
      ranges = xRanges(lst,opt)
      (say r for r in ranes)

