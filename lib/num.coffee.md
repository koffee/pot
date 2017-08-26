    our = require 'our'

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
   
