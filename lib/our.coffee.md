[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

# Our Shared Stuff

## How to call this code

    Usage="""
            
      export Koffee="$PWD"                    # can also be set in .bashrc
      export NODE_PATH="$PWD/lib:$NODE_PATH"  # can also be set in .bashrc
      coffee lib/FILE.coffee.md

    Or, if you don't want to set globals in the envrionment:

      NODE_PATH="$PWD/lib:$NODE_PATH" Koffee="$PWD" coffee lib/FILE.coffee.md
    """

## Start up checks

    for x in ['NODE_PATH', 'Koffee']
      unless process.env[x]
        console.log "Abort. No #{x} variable set."
        console.log "Recommended usage: " + Usage
        process.exit()

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

Recursive print of things. Ignores attributes shose first symbol
is "\_". Crashes on recursive contents
(until I figure out how to hash coffeescript objects... anyone?)

    rsay = (x,lvl=0,pad="") ->
      return if lvl > 10
      prim = (p) -> typeof p in ['number', 'sting', 'boolean']
      name = (v) ->
               tmp= v.constructor.name
               if tmp in ['Array','Object'] then "" else tmp
      if prim(x)
        console.log 100+pad + x
      else if x.constructor.name is 'Array'
        for v in x
          if prim(v)
            console.log pad + v
          else
            console.log pad +  name(v)
            rsay(v,lvl+1, pad+"  ")
      else if typeof x isnt 'function'
        for k,v of x when k[0] isnt "_"
          if prim(v)
            console.log pad + "#{k}: #{v}"
          else
            console.log pad + k + ": " + name(v)
            rsay(v,lvl+1,pad + "  ")
  
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
            console.log "\n-----| SUCCESS!! |--------------------\n"
        catch error
            console.log "\n-----| FAILURE!! |--------------------\n"
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

## Some test/demo function

     memoEg = ->
       fib = memoize (n) ->
         if n < 2 then n else fib(n-1) + fib(n-2)
       O.k -> assert fib(40,1,10) is  102334155,"wrong value"

    oEg = ->
       xx = (a) -> assert a> 0,"should be positive"
       O.k -> xx(1)
       O.k -> xx(0)

    rsayEg = ->
       class Demo1
         constructor: (@c=41,@d=22) ->
       class Demo
         constructor: (@a=41,@b=new Demo1) ->
       rsay
         c: [1,2,3,new Demo]
         b: 23
         d:
           e: new Demo
           g: {"aa":2, "bb":4}

## And finally

     @say = say
     @rsay = rsay
     @memoize = memoize
     @O = O
     if require.main == module
       memoEg()
       oEg()
       rsayEg()
       O.darn()
       
