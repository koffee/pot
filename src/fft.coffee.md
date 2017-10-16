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
    
    class 

    fft = (file=data + 'weather2.csv') ->
      medians = {}
      pre = -> 
        t= new Table
        t.from file, -> post(t)
      post = (t) ->
        say t.rows.length
        for num in  t.
      pre()
   
    median = (col,t, lo,hi) ->
      lst = t.rows.sort (a,b) -> a.cells[col] - b.cells[col]
      n   = lst.length
      mid = n // 2
      (lo( lst[i] ) for i in [0..mid])
      (hi( lst[i] ) for i in [mid+1....n])

      lst[mid].cells[col]

#
## End stuff

    @fft = fft
    @tests=[ egFft ]
    f() for f in @tests if require.main is module
