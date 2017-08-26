[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.png>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 











    class num
      constructor: (txt) ->
        @name : word
        @min  : our.inf
        @max  : our.ninf
      prep : (x,h) -> asNum x,h}  
    asNum = (x,h) -> 
      y = +x  # coerce string to num
      h.min = y if y < h.min
      h.max = y if y > h.max
      y
    
    numHeader = (word) -> {
   
