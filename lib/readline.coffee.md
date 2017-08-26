    readline  = require 'readline'
    fs        = require 'fs'
    
    lines_of = ( file, action ) ->
      stream = readline.createInterface
        input:    fs.createReadStream file
        output:   process.stdout
        terminal: false
      stream.on 'close',           -> action null, null
      stream.on 'error', ( error ) -> action error
      stream.on 'line',  ( line )  -> action null, line

    lines_of "aa.coffee.md" , (err,line) ->
       if line? then console.log("[" + line + "]")
