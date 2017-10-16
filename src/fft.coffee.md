[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[tour](https://github.com/koffee/script/blob/master/doc/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/doc/STYLE.md)

# Table reader

Example usage

    egFft = ->
      fft()

Setting up

    src     = process.env.PWD + "/../src/" 
    data    = process.env.PWD + "/../data/" 
    {say,want} = require src+'our'
    {Table}   = require src+'table'
    {ABCD}   = require src+'abcd'

# with pretty print strings and constructors with column name

    class More

    class Less

    class Is

    class  Rule
      constructor: (@col,@accepts,@want) ->
        @has = new ABCD
        @does = []
        @dont = []
      add: (t,row) ->
        val = row.cells[@col]
        @has.add @want val, @accepts row
        (if @accepts row then @does else @dont).push row
      best: (that) ->
        if that is null 
          this
        else
          if @has.acc > that.has.acc then this else that

    fft = (c,file=data + 'weather2.csv') ->
      pre = () -> 
        t= new Table
        t.from file, (-> post(t))
      post = (t) -> say t.rows.length
      pre()

    bestSum = (col,t,goal,best=null) ->
      all = {}
      for row in t.rows
        val = row.cells[col]
        all[val] or= new Rule col, ((z) -> z==val), ((z) -> z.klass(t) == goal)
        all[val].add t,rows[i]
      for _,rule of all
        best = rule.best best
      best
  
    bestNum = (col,t,goal,best=null) ->
      rows = t.rows.sort((a,b) -> a.cells[col] - b.cells[col])
      n   = lst.length 
      mid = n // 2
      lo = new Rule col,((z) -> z<mid),  ((z) -> z.klass(t) == goal) 
      hi = new Rule col,((z) -> z>=mid), ((z) -> z.klass(t) == goal) 
      (lo.add t,rows[i] for i in [0..mid-1])
      (hi.add t,rows[i] for i in [mid .. n-1])
      (lo.best hi).best best

## End stuff

    @fft = fft
    @tests=[ egFft ]
    f() for f in @tests if require.main is module
