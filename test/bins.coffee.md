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
      rx1=['xb1', 0.34, 0.49, 0.51, 0.6]
      rx2=['xc2', 1.6 , 1.7 , 1.8,  1.9]
      rx3=['xa3', 0.015, 0.025, 0.04,  0.035]
      rx4=['xc4', 1.6 , 1.7 , 1.8,  1.9]
      rx5=['xa5', 0.01 , 0.027 , 0.035,  0.04]
      console.log ""
      for x,i in sk([rx1,rx2,rx3,rx4,rx5])
        console.log i, x.rank, x.txt, x.has.mu

    eg3 = ->
      console.log ""
      for x,i in sk([["x1",0.34, 0.49, 0.51, 0.6],
                       ["x2",6,  7,  8,  9] ])
        console.log i, x.rank, x.txt, x.has.mu

    eg4 = ->
      console.log ""
      for x,i in sk([  ["x1",0.1,  0.2,  0.3,  0.4],
                       ["x2",0.1,  0.2,  0.3,  0.4],
                       ["x3",6,  7,  8,  9]])
        console.log i,x.rank,x.txt,x.has.mu

    eg5 = ->
      console.log ""
      for x,i in sk([  ["x1",0.34, 0.49, 0.51, 0.6],
                       ["x2",0.6,  0.7,  0.8,  0.9],
                       ["x3",0.15, 0.25, 0.4,  0.35],
                       ["x4",0.6,  0.7,  0.8,  0.9],
                       ["x5",0.1,  0.2,  0.3,  0.4] ])
        console.log i,x.rank,x.txt,x.has.mu

    eg6 = ->
     console.log ""
     for x,i in sk([ ["x1",101, 100, 99,   101,  99.5],
                     ["x2",101, 100, 99,   101, 100],
                     [ "x3",101, 100, 99.5, 101,  99],
                     ["x4",101, 100, 99,   101, 100] ])
        console.log i,x.rank,x.txt,x.has.mu
   
    eg7 = ->
     console.log ""
     for x,i in sk([["x1",11,12,13],
                    ["x2",14,31,22],
                    ["x3",23,24,40],
                    [ "x5",29,30,34]]) 
        console.log i,x.rank,x.txt,x.has.mu

 
    eg8 = ->
      console.log ""
      for x,i in sk([["x1",11,11,11],
                     ["x2",11,11,11],
                     ["x3",11,11,11]])
        console.log i,x.rank,x.txt,x.has.mu

    eg9 = ->
      console.log ""
      for x,i in sk([["x1",11,11,11],
                     ["x2",11,11,11],
                     ["x3",211,211,211]])
        console.log i,x.rank,x.txt,x.has.mu

    eg10 = ->
      console.log ""
      r = new Rand
      n = 10**5
      for x,i in sk([
          ["x1", (r.next()**0.5 for [1..n])...],
          ["x2", (r.next()**2 for [1..n])...],
          ["x3", (r.next()    for [1..n])...]])
       console.log i,x.rank,x.txt,x.has.mu


Run stuff

    eg1()
    eg2()
    eg3()
    eg4()
    eg5()
    eg6()
    eg7()
    eg8()
    eg9()
    eg10()
