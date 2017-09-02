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

    class o
      @tries=0
      @failed=0
      @k: (funs...) ->
        say funs
        (o.test(f) for f in funs)
      @test: (f) ->
        o.tries++
        try
            f()
        catch error
            console.log error
            o.failed++
      @darn : ->
        fail =  o.tries - o.fail
        f  = (x)  -> Math.floor(100*x)
        console.log
           pass: f (o.tries - o.failed)/o.tries
           fail: f o.failed/o.tries

## Magic

    String::last = ->
      this[ this.length - 1]

# END
 
     this.say = say
     this.o   = o
     if require.main == module
       fib = memoize (n) ->
         if n < 2 then n else
             fib(n-1) + fib(n-2)
       o.k -> assert fib(40,1,10) is  102334155,"wrong value"
       xx = (a) -> assert(a> 0,"should be positive")
       o.k -> assert(false, "false things")
       o.k -> assert(xx(0), "should not crash")
       o.darn()
