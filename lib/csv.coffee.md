[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 


# CSV reader

    lines = require('./lines').lines
    the   = require('./the')

The `csv` class does not store data. Rather, it parses lines of
comma-seperated values and thows each line, one at a time, at
`@action`.

    class csv
      constructor: (file, action) ->
        [ @_useful, @cache ] = [ [],[] ]
        @action  = action

Ignore any column that contains the magic `the.ignore` chanracter.
Kill white space and comments. If any line ends with "," then merge
to the next line.  Split the line into cells.  Pass the un-ignored
cells to the `@action` function.

      add: (s) ->
        s = s.replace csv./\s/g,''
        s = s.replace csv./#.*/,''
        if s.length then
          if   s.last() is ','
          then @cache.push s
          else
            s = @cache.join()
            @cache = []
            cells = s.split ','
            if not @_useful then
              for i,cell in cells
                @_useful.push i unless the.ignore in cell
            if cells.length then
              action (@prep cells[i] for i in @_useful)

As to prepping each cell in the line, if we can compile a string to a number,
use that number. Else, use the string as-is.

      prep: (s) ->
        t = +s
        if Number.isNan(t) then s else t

## Expert control

    this.csv = csv
