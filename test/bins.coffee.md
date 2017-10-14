    src = process.env.PWD + "/../src/" 
    
    {Rand}         = require src + 'rand'
    {assert,say,O} = require src + 'our'
    {Bins,sk}    = require src + 'bins'
    
    eg1 = ->
      r= new Rand(1)
      pair = () ->
        x = r.next()**2
        x = Math.floor(x * 100)
        switch
          when x < 20 then  [x,10]
          when x < 60 then  [x,40]
          else [x,80]
      
      pairs= (pair()  for x in [0..10000]) 
      b= new Bins(pairs)
      
      for [x,y] from b.xrange()
        say "unper> #{x.has.n} lo: #{x.has.lo} hi: #{x.has.hi} y: #{(y.has.hi+y.has.lo)/2}"
      
      say ""
      for [x,y] from b.yrange()
        say "super> #{x.has.n} lo: #{x.has.lo} hi: #{x.has.hi} y: #{(y.has.hi+y.has.lo)/2}"
      
Treatmetnts

    eg2 = ->
      rx1=['x1', 0.34, 0.49, 0.51, 0.6]
      rx2=['x2', 0.6 , 0.7 , 0.8,  0.9]
      rx3=['x3', 0.15, 0.25, 0.4,  0.35]
      rx4=['x4', 0.6 , 0.7 , 0.8,  0.9]
      rx5=['x5', 0.1 , 0.2 , 0.3,  0.4]
      console.log ""
      for x,i in sk([rx1,rx2,rx3,rx4,rx5])
        console.log i, x.rank, x.txt, x.has.mu

    eg3 = ->
      console.log ""
      for x,i in sk([["x1",0.34, 0.49, 0.51, 0.6],
                       ["x2",6,  7,  8,  9] ])
        console.log i, x.rank, x.txt, x.has.mu

Run stuff

    eg1()
    eg2()
    eg3()
