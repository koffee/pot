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
comma-seperated values and thows each line, one at a time, to
`action`.

- csv contructior passes the `line` method to the  `lines` reader;
- `line` kills dull characters and passes non-empty strings to `merge`.
- `merge` combines any lines that end with a comma into the next line
- `usable` looks for "?" characters on line one and, if there,
  makes a memo that that column is to be ignored
- `add` coerces strings to numbers, if needed. then
  passes the the usable coerced cells to `action`.

The  code that line one contain words indicating that some (perhaps
none) of the columns are to be ignored.  Such columns have words in
column one contain the character `the.ignore`.

## Code

    class csv

      constructor: (file, action) ->
        @_use    = []
        @memo    = []
        @action  = action
        lines file, (s) =>
          if s
            @line s

Kill whitespace. Kill comments. Ignore empty lines.

      line: (s) ->
        s = s.replace /\s/g,''
        s = s.replace /#.*/,''
        if s.length
          @merge s

Ignore any column that contains the magic `the.ignore` chanracter.
If any line ends with "," then merge
to the next line.  Split the final merged into cells.  

      merge: (s) ->
        @memo.push s                   # always add to memo
        if s.last() != ','             # if we dont need tp merge with next
          @add  @memo.join().split ',' # merge memos, split of comma, pass to "add"
          @memo = []                   # wipe knowledge of old lines

Pass the useable  cells to the `action` function.

      add:  (cells) ->
        if cells.length
          @action (@prep cells[i] for i in @use(cells))

To prep each cell, if we can compile a string to a number,
use that number. Else, use the string as-is.

      prep: (s) ->
        t = +s
        if Number.isNaN(t) then s else t

Cells are useful if row1's cell did not contain `the.ignore`

      use: (cells) ->
        if not @_use.length
          for cell,i in cells
            @_use.push i unless the.ignore in cell
        @_use

    ## Expert control

    this.csv = csv

## Examples

    if require.main == module
      new csv the.data + '/weather2.csv',(s) ->
        the.say(s)


