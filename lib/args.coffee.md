[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# ARGS

     do
       egs = ->
         for x,y of this
           console.log x
         for x,y of this when typeof y is 'function' and x.match(/Eg$/)
           console.log x,y
           
       a = () -> console.log 'a'
       b = () -> console.log 'b'
       c = 231
  
       xEga = () -> console.log 'd'
       xEg  = () -> console.log 'e'
  
     if require.main == module
       egs()
