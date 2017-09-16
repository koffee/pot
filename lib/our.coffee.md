[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# Our Shared Stuff

## Shared Constants

    @ninf   = -1 * (Number.MAX_SAFE_INTEGER - 1)
    @inf    = Number.MAX_SAFE_INTEGER
    @tiny   = 1 / @inf
    @ignore = '?'
    @conf   = 95
    @data   = process.env["Koffee"] + "/data" or "../data"

## Shared functions

Print a list of things.

    say = (l...) ->
      sep=" "
      w = (s) -> process.stdout.write(s)
      for x in l
        w(sep+ x)
        sep=", "
      w("\n")

Recursive print of things. Will crash on recursive contents
(until I figure out how to hash coffeescript objects... anyone?)

    rshow = (x,lvl=0) ->
      return if lvl > 10
      prim = (p) -> typeof p in ['number', 'sting', 'boolean']
      use  = (s) -> s[0] isnt "_"
      pad  = "  ".repeat(lvl)
      name = (v) ->
               tmp= v.constructor.name
               if tmp in ['Array','Object'] then "" else tmp
      if prim(x)
        console.log pad + x
      else if typeof x isnt 'function'
        if x.constructor.name is 'Array'
          for v in x
            if prim(v)
              console.log pad + v
            else
              console.log pad +  name(v)
              rshow(v,lvl+1)
        else
          for k,v of x when use(k)
            if prim(v)
              console.log pad + "#{k}: #{v}"
            else
              console.log pad + k + ": " + name(v)
              rshow(v,lvl+1)
  
Memoize

    memoize = (func) ->
      # if called with no args, resets the memos
      memo = {}
      (arg, args...) ->
        if arg is null 
          memo={}
        else
          memo[arg] = func arg,args... unless  memo[arg]
          memo[arg]

Unit test 

    assert= (f,t) -> throw new Error t or "" if not f

    class O
      @tries=0
      @failed=0
      @k: (funs...) ->
        say funs
        (O.test(f) for f in funs)
      @test: (f) ->
        O.tries++
        try
            f()
        catch error
            console.log error.stack.split('\n')[0..2].join("\n")
            O.failed++
      @darn : ->
        fail =  O.tries - O.fail
        f  = (x)  -> Math.floor(100*x)
        console.log
           pass: f (O.tries - O.failed)/O.tries
           fail: f O.failed/O.tries

## Magic

    String::last = ->
      this[ this.length - 1]

# END

     @say = say
     @O   = O
     if require.main == module
       # memoization test
       fib = memoize (n) ->
         if n < 2 then n else
             fib(n-1) + fib(n-2)
       O.k -> assert fib(40,1,10) is  102334155,"wrong value"
       # testing the test ending
       xx = (a) -> assert a> 0,"should be positive"
       O.k -> xx(1)
       O.k -> xx(0)
       O.darn()
       # recursive print demo
       class Demo1 
         constructor: (@c=41,@d=22) ->
       class Demo 
         constructor: (@a=41,@b=new Demo1) ->
       rshow
         c: [1,2,3,new Demo]
         b: 23
         d: 
           e: new Demo
           g: {"aa":2, "bb":4}
