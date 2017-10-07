[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/src) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# LINES

Read a file, pass one line at a time to some `action` handler.

    src = process.env.PWD + "/../src/" 
    readline  = require 'readline'
    fs        = require 'fs'
   
    lines = ( file, action, done = (-> ) ) ->
      stream = readline.createInterface
        input:    fs.createReadStream file
        output:   process.stdout
        terminal: false
      stream.on 'close',           -> done()
      stream.on 'error', ( error ) -> action error
      stream.on 'line',  ( line  ) -> action line 


    egLines = () ->
       lines '../data/weather2.csv',(t) ->  console.log(t)

    @lines = lines
    @tests = [egLines]

