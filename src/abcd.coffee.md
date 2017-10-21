[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[tour](https://github.com/koffee/script/blob/master/doc/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/doc/STYLE.md)


Example

    egABCD = ->
      """
      yes no maybe <- predicted as
      6            | yes
          2        | no
          1  5     | maybe
      """
      abcd = new ABCD
      abcd.add("yes","yes")     for i in [1..6]
      abcd.add("no","no")       for i in [1..2]
      abcd.add("maybe","maybe") for i in [1..5]
      abcd.add("maybe","no")
      y = abcd.report()
      want y.yes.acc.toFixed(2) == '0.93'
      want y.no.prec.toFixed(2) == '0.67'
      want y.maybe.g.toFixed(2) == '0.91'

Setup

    src = process.env.PWD + "/../src/" 
    {say,rsay,want} = require src+'our'

Code

    class ABCD
      constructor: (round=3) ->
        @a   = {} ; @b  = {} ; @c   = {} ; @d = {}
        @yes = 0  ; @no = 0  ; @all = {}
        @round = round
    
      add:(actual,predicted) ->
        @known(actual)
        @known(predicted)
        if actual is predicted then @yes +=1 else @no += 1
        for target,ignore of @all
          @known(target)
          if (actual is target)
            if predicted is actual then @d[target] += 1 else @b[target] += 1
          else
            if predicted is target then @c[target] += 1 else @a[target] += 1
    
      known: (x) ->
        @a[x] or= 0
        @b[x] or= 0
        @c[x] or= 0
        @d[x] or= 0
        @a[x]= @yes + @no if ++@all[x] is 1
    
      acc: ->
        if (@yes+@no) > 0 then @yes / (@yes+@no) else 0
         
      report1: (k,a,b,c,d) ->
        y      = {}
        y.pd   = y.pf = y.prec = y.f = y.g = y.pn = 0
        y.pd   = d     / (b+d) if (b+d) > 0
        y.pf   = c     / (a+c) if (a+c) > 0
        y.pn   = (b+d) / (a+c) if (a+c) > 0
        y.prec = d     / (c+d) if (c+d) > 0
        y.g    = 2*(1-y.pf)*y.pd / (1-y.pf+y.pd)  if (1-y.pf+y.pd)    > 0
        y.f    = 2*y.prec*y.pd   / (y.prec+y.pd)  if (y.prec+y.pd)    > 0
        y.acc  = @acc()
        y
    
      report: () ->
        y = {}
        for k,val of @all
          y[k]  = @report1 k,@a[k],@b[k],@c[k],@d[k]
        y

End stuff

    @ABCD = ABCD
    @tests = [ egABCD ]
    (f() for f in @tests if require.main is module)
