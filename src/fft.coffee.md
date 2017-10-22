[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[tour](https://github.com/koffee/script/blob/master/doc/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/doc/STYLE.md)

# Table reader

#Example usage

    egFft = ->
      say 3
      fft()

#Setting up

    src     = process.env.PWD + "/../src/"
    data    = process.env.PWD + "/../data/"
    {say,want} = require src+'our'
    {Table}   = require src+'table'
    {ABCD}   = require src+'abcd'

# with pretty print strings and constructors with column name

    class Compare
      @upTo = (what,col,val) ->
        new Compare what,col,val,'<=',  (a,b) => a <= b
      @above = (what,col,val) ->
        new Compare what,col,val,'>',  (a,b) => a  > b
      @is = (what,col,val) ->
        new Compare what,col,val,'==', (a,b) => a == b
      constructor: (@what,@col,@val,@show,@f) ->
      toString   :  -> return "#{@what} #{@show} #{@val}"
      good       : (x) -> @f( x[@col], @val)

    class  Constraint
       @acc = (x,y) =>
         new Constraint x,y, (z) => say(z); z.acc()
       @y = (t) => (goal) => row.klass(t) == goal
       constructor: (@x,@y,@score) ->
         @abcd = new ABCD
         @bad = []
       toString : ->
         'if ' + @x.toString() + ' then ' + @y.toString() + ' so ' + @abcd.acc()
       add: (that) ->
         @abcd.add @y(that), @x.good(that)
         @bad.push that if not @x.good(that)
       better: (that) ->
         if that is null
           this
         else
           if @score(@abcd) > @score(that.abcd) then this else that

    fft = (file=data + 'weather.csv') ->
      t=new Table
      t.from file, (-> fft1(t))

    fft1= (t, out) ->
      say 1
      for num in t.x.nums
        say num
        out = bestNum num,t,"yes",out
      say out
      want 14 == t.rows.length

    bestSum = (col,t,goal,best=null) ->
      all = {}
      for row in t.rows
        val = row.cells[col]
        if not val in all
          here = Constraint.acc(Compare.is(col.txt.col.pos,val),
                                (row) => row.klass(t) == goal)
      for row in t.rows
        val[row.cells[col]].add row
      for _,rule of all
        best = rule.better best
      best

    bestNum = (col,t,goal,best=null) ->
      mid      = t.median(col)
      say "median",mid
      goody   = (row) => row.klass(t) == goal
      goodxlo = Compare.upTo(col.txt, col.pos,mid)
      goodxhi = Compare.above(col.txt, col.pos,mid)
      below   = Constraint.acc( goodxlo, goody)
      above   = Constraint.acc( goodxhi, goody)
      for row in t.rows
        below.add row
        above.add row
      (below.better above).better best

## End stuff

    @fft = fft
    @tests=[ egFft ]
    f() for f in @tests if require.main is module
