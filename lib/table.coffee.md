[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# Table reader

    csv= require('./csv')
    row= require('./row')

    class table
      constructor: (spec) ->
        @cols= {all: [], nums:[], syms: []}
        @x   = {all: [], nums:[], syms: []}
        @y   = {all: [], nums:[], syms: [],
                klasses: [], less: [], more: []}
        @spec=[]
        @rows=[]
        (@header txt,pos for txt,pos in spec) if spec
      copy: (rows) -> # shares internal data
        rows or= @rows
        t = new table @spec
        (t.data row for row in rows)
        t
      deepCopy: (rows) -> # all seperate data
        rows or= @rows
        t = new table @spec
        (t.data( new row row.cells ) for row in rows)
        t
      add: (cells) ->
        if @spec.length
          @data(new row cells)
        else
          (@header txt,pos for txt,pos in cells)
      data: (row) ->
        @rows.push row
        (col.add row.cells[col.pos] for col in @cols.all)
      header: (txt,pos)
        create = (col,w, theres...) ->
          col.pos = pos
          col.w   = w
          col.txt = txt
          @spec.push txt
          @cols.all.push col
          (here.push col for here in theres)
        if      ">" in txt create(new num,  1, @all.nums, @y.nums, @y.more)
        else if "<" in txt create(new num, -1, @all.nums, @y.nums, @y.less)
        else if "!" in txt create(new sym,  1, @all.syms, @y.syms, @y.klasses)
        else if "$" in txt create(new num,  1, @all.nums, @x.nums)
        else               create(new sym,  1, @all.syms, @x.syms)

    file2table=(file) ->
      t = new table
      reader = csv file, (row) ->  t.update(row), -> t=t
      t
        
    countRows = (file) ->
      n=0
      new csv file,
          -> ++n,
          -> _.say "rows: " + n

## Code

    reader = require('./lines').lines
    _ = require('./our')

**Constructor**

    class csv
      constructor: (file, action, over) ->
        @use     = null
        @lines    = []
        @action  = action
        reader file, @line, over or ->

**Process each line.**
Ignore eof, kill whitepace and comments. If anything left, called `merge`.

      line: (s) =>
        if s
          s = s.replace /\s/g,''
          s = s.replace /#.*/,''
          if s.length
            @merge s

**Merge lines ending with "," to the next line.**
Split the result into cells then send the result to `act`.

      merge: (s) ->
        @lines.push s
        if s.last() isnt ','
          @act @lines.join().split ','
          @lines = []

**Act on each line.**
Pass the useable  cells to the `action` function.
Cells are useful if row1's cell did not contain `the.ignore`

      act: (cells) ->
        if cells.length
          @use or= (i for c,i in cells when _.ignore not in c)
          @action (@prep cells[i] for i in @use)

**Prep each cell.**
If we can compile a string to a number,
use that number. Else, use the string as-is.

      prep: (s) ->
        t = +s
        if Number.isNaN(t) then s else t

## End stuff

    @csv = csv
    if require.main == module
      printColumn3 _.data + '/weather2.csv'
      countRows    _.data + '/POM3A.csv'
