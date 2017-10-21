[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[tour](https://github.com/koffee/script/blob/master/doc/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/doc/STYLE.md)

# Table reader

Example usage

    standardDeviation2ndNumericColumn = ->
      t = new Table
      t.from data + '/weather2.csv' , -> 
        sd= t.xy.nums[1].sd
        want sd.toFixed(2) == '17.03'

Setting up

    src     = process.env.PWD + "/../src/" 
    data    = process.env.PWD + "/../data/" 
    {say,want} = require src+'our'
    {Csv}   = require src+'csv'
    {Row}   = require src+'row'
    {Num}   = require src+'num'
    {Sym}   = require src+'sym'

    class Table
      constructor: (spec) ->
        @xy= {all:[], nums:[], syms:[]}
        @x = {all:[], nums:[], syms:[]}
        @y = {all:[], nums:[], syms:[], klasses:[], less:[], more:[]}
        @spec = []
        @rows = []
        @headers spec if spec
      add: (cells) ->
        if @spec.length then @data(new Row(cells)) else @headers cells
      data: (row) ->
        @rows.push row
        (col.add row.cells[col.pos] for col in @xy.all)
      headers: (cells) ->
        (@header txt,pos for txt,pos in cells)
      header: (txt,pos) ->
        h = (what,w,there) =>
          @spec.push txt
          col = new what txt,w,pos
          @xy.all.push col
          (here.push col for here in there)
        return h(Num, 1,[@xy.nums,@y.nums,@y.more   ]) if "?" in txt
        return h(Num,-1,[@xy.nums,@y.nums,@y.less   ]) if "<" in txt
        return h(Sym, 1,[@xy.syms,@y.syms,@y.klasses]) if "!" in txt
        return h(Num, 1,[@xy.nums,@x.nums])            if "$" in txt
        return h(Sym, 1,[@xy.syms,@x.syms])
      from: (file, after = ->) ->
        new Csv file, ((row) => @add row), after
      copy: (rows) -> # shares internal data
        t = new Table @spec
        (t.data row for row in rows or @rows)
        t
      deepCopy: (rows) -> # all seperate data
        t = new Table @spec
        (t.data( new Row(row.cellsi)  ) for row in rows or @rows)
        t

## End stuff

    @Table = Table
    @tests=[ standardDeviation2ndNumericColumn ]
