x

# RANDOM

Knuth and Lewis' improvements to Park and Miller's LCPRNG
if created without a seed, uses current time as seed

    class @rand
      @seed0: 10013
      @mult:  16807
      @mod:   2147483647
      constructor: (n) -> @reset(n)
      #--------------------
      reset: (n) ->
        @some = null
        @seed = n or rand.seed0
      #--------------------
      fromOS: () ->
        @reset( (new Date().valueOf() *
                 new Date().getMilliseconds()) % rand.mod)
      #--------------------
      one: () ->
        @seed = (rand.mult * @seed) % rand.mod
        @seed / rand.mod
      #--------------------
      next: () ->
        @some = @some or (@one() for [1..97])
        x = @one()
        i = Math.floor 97*x
        [ x,@some[i] ] = [ @some[i],x ]
        x
