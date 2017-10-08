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

## Shared functions

Print a list of things.

    say = (l...) ->
      sep=" "
      w = (s) -> process.stdout.write(s)
      for x in l
        w(sep+ x)
        sep=", "
      w("\n")

Zip 

    zip = (arrs...) ->
      lengths = (arr.length for arr in arrs)
      length = Math.min(lengths...)
      console.log 'l:',length
      for i in [0...length-1]
        yield (arr[i] for arr in arrs)

Zip eg:

    console.log 100
    for x of zip([10,20,30],[11,21,31],[12,22,32])
      console.log "!!",x

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

Clone. Deep copy. Simplified version of the
one in the Coffeescript cookbook https://goo.gl/pojT3E.

    clone = (obj) ->
      if not obj? or typeof obj isnt 'object'
        return obj
      out = new obj.constructor()
      for key of obj
        out[key] = clone obj[key]
      return out

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

    want   = (x) -> O.k(-> assert x)
    assert = (f,t) -> throw new Error t or "" if not f

    class O
      @tries=0
      @failed=0
      @k: (funs...) ->
        (O.test(f) for f in funs)
      @test: (f) ->
        O.tries++
        try
            s="==========="
            console.log "\n"+s+s+s+s+s+s+s
            f()
            console.log "\n-----| SUCCESS!! |--------------------\n"
            O.darn()
        catch error
            console.log "\n-----| FAILURE!! |--------------------\n"
            console.log error.stack.split('\n')[0..2].join("\n")
            O.failed++
            O.darn()
      @darn : ->
        fail =  O.tries - O.fail
        f  = (x)  -> Math.floor(100*x)
        console.log
           tries: O.tries
           pass: f (O.tries - O.failed)/O.tries
           fail: f O.failed/O.tries

## Magic

    String::last = ->
      this[ this.length - 1 ]

# END

     @O       = O
     @zip     = say
     @say     = say
     @rsay    = rsay
     @want    = want
     @clone   = clone
     @assert  = assert
     @memoize = memoize
