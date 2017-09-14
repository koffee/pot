[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# Table reader

    _   = require('./our')
    csv = require('./csv').csv
    row = require('./row').row
    num = require('./num').num
    sym = require('./sym').sym

    class table
      constructor: (spec) ->
        @xy  = {all: [], nums:[], syms: []}
        @x   = {all: [], nums:[], syms: []}
        @y   = {all: [], nums:[], syms: [], klasses: [], less: [], more: []}
        @spec = []
        @rows = []
        @headers spec if spec
      add: (cells) ->
        if @spec.length then @data(new row cells) else @headers cells
      data: (row) ->
        @rows.push row
        (col.add row.cells[col.pos] for col in @xy.all)
      headers: (cells) ->
        (@header txt,pos for txt,pos in cells)
      header: (txt,pos) ->
        head = (what,w,theres) =>
          @spec.push txt
          col = new what txt,w,pos
          @xy.all.push col
          (here.push col for here in theres)
        return head(num,  1, [@xy.nums, @y.nums, @y.more])    if "?" in txt
        return head(num, -1, [@xy.nums, @y.nums, @y.less] )   if "<" in txt
        return head(sym,  1, [@xy.syms, @y.syms, @y.klasses]) if "!" in txt
        return head(num,  1, [@xy.nums, @x.nums])             if "$" in txt
        return head(sym,  1, [@xy.syms, @x.syms])
      from: (file, after = ->) ->
        new csv file, (row) => @add row, => _.say t
      copy: (rows) -> # shares internal data
        t = new table @spec
        (t.data row for row in rows or @rows)
        t
      deepCopy: (rows) -> # all seperate data
        t = new table @spec
        (t.data( new row row.cells ) for row in rows or @rows)
        t

## End stuff

    if require.main == module
      t = new table
      t.from _.data + '/weather2.csv' , => _.say t
    @table = table

