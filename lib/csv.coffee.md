[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# CSV reader

This `csv` class does not store data. Rather, it parses lines of
comma-seperated values and thows each line, one at a time, to
some `action`.


- In row1 of the file, if any column contains "?", then that column is ignored.
- If any row ends in ",", it is combined with the next.
- Strings containing numbers are coerced into numbers.
- Whitespace and comments (anything after "#") are deleted.

## Examples

The csv constructor accepts an action to be run on every line.

    printColumn3 = (file) ->
      new csv file,
              (row) -> the.say row[3]

Optionally, the `csv` constructor accepts an second
argument defining what to do at end of file.

    countRows = (file) ->
      n=0
      new csv file,
          -> ++n,
          -> the.say "rows: " + n

## Code

    reader = require('./lines').lines
    the   = require('./the')
    class csv
      constructor: (file, action, over) ->
        @use     = null
        @lines    = []
        @action  = action
        reader file, @line, over or @done

Ignore eof, kill whitepace and comments. If anything left, called `merge`.

      line: (s) =>
        if s
          s = s.replace /\s/g,''
          s = s.replace /#.*/,''
          if s.length
            @merge s

      done: () ->

Until the line does not end with "," keep adding the row to a `memo`
of previous lines. Then, merge all the memos, split on ",", the
send the result to `act`.

      merge: (s) ->
        @lines.push s                  # always add to memo
        if s.last() isnt ','           # if no merge needed
          @act @lines.join().split ',' # merge and split on comma
          @lines = []                  # wipe knowledge of old lines

Pass the useable  cells to the `action` function.
Cells are useful if row1's cell did not contain `the.ignore`

      act: (cells) ->
        if cells.length
          @use or= (i for c,i in cells when the.ignore not in c)
          @action (@prep cells[i] for i in @use)

To prep each cell, if we can compile a string to a number,
use that number. Else, use the string as-is.

      prep: (s) ->
        t = +s
        if Number.isNaN(t) then s else t

## End

    this.csv = csv
    if require.main == module
      printColumn3 the.data + '/weather2.csv'
      countRows    the.data + '/POM3A.csv'
