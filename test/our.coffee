src = process.env.PWD + "/../src/"
{want, memoize, rsay, clone} = require src+'our'

memoEg = ->
   fib = memoize (n) ->
     if n < 2 then n else fib(n-1) + fib(n-2)
   fib(40,1,10) is  102334155

oEg = ->
   10 > 0

class Demo1
  constructor: (@c=41,@d=22) ->

class Demo
  constructor: (@a=41,@b=new Demo1) ->

rThing = ->
  c: [1,2,3,new Demo]
  b: 23
  d:
    e: new Demo
    g: {"aa":2, "bb":4}

rsayEg = ->
   rsay rThing()

cloneEg = ->
   old= rThing()
   now= clone old
   now.d.e.a= 10000
   now.c[0] = 10000
   now.d.e.a isnt old.d.e.a

want memoEg()
want oEg()
want rsayEg()
want cloneEg()
