a

asdasas as asd asda sdas dasd asa

    readline  = require 'readline'
    fs        = require 'fs'
   
    say = (f) -> console.log(f)

    lines_of = ( file, action ) ->
      stream = readline.createInterface
        input:    fs.createReadStream file
        output:   process.stdout
        terminal: false
      stream.on 'close',           -> action null, null
      stream.on 'error', ( error ) -> action error
      stream.on 'line',  ( line  ) -> action null, line

    lines_of "aa.coffee.md" , (_,l) -> 
      if l? then say(l)
