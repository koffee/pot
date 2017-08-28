[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koffee)<br>
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

    printColumn3 = (file) -> 
      new csv file, (row) -> the.say row[3]

## Code

    reader = require('./lines').lines
    the   = require('./the')

    class csv
      constructor: (file, action) ->
        @use     = null
        @lines    = []
        @action  = action
        reader file, (s) =>
          if s                      # ignore eof
            s = s.replace /\s/g,''  # kill whitespace
            s = s.replace /#.*/,''  # kill comments
            if s.length             #  anything left?
              @merge s

If any line ends with "," then merge
to the next line.  Split the final merged into cells.  

      merge: (s) ->
        @lines.push s                   # always add to memo
        if s.last() isnt ','            # if we dont need tp merge with next
          @act  @lines.join().split ',' # merge memos, split on comma, pass to "act"
          @lines = []                   # wipe knowledge of old lines

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
