[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.png>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 


# CSV reader

    lines = require('./lines').lines
    the   = require('./the')

    class csv
      constructor: (file, action) ->
        [ @_useful, @cache ] = [ [],[] ]
        @action  = action
      prep: (s) ->
        t = +s
        if Number.isNan(t) then s else t
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

    this.csv = csv
