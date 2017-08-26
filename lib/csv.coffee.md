    #
    #    fs = require 'fs'
    #    
    #    say =  (f) -> console.log(f)
    #
    #    lines = (f) ->
    #      for line in fs.readFileSync(f).toString().split '\n'
    #        yield line
    #      return
    #
    #
    #    read1 = (f, fn) ->
    #       fs.readFile f, "utf8",  (err, data) ->
    #         if data?
    #           fn console.log("[" + data.toString() + "]")
    #
    fs = require 'fs'
    byline = require 'readline-stream'

    stream = fs.createReadStream('aa.coffee.md')
    stream = stream.pipe(ReadlineStream())

    stream.on 'data', (line) ->
      say "[" + line + "]"

