[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md)

# RAND

For test portabilty, I need a random number generator that produces the same numbers on different platforms.

This generator is a so-called 'Lehmer random number generator' which returns a pseudo-random number uniformly distributed 0.0 and 1.0. The period is (m - 1) where m = 2,147,483,647 and the smallest and largest possible values are (1 / m) and 1 - (1 / m) respectively. For more details see:

- _Random Number Generators: Good Ones Are Hard To Find_ Steve Park and Keith Miller Communications of the ACM, October 1988

## Examples

    fiveRandomNumbers = ->
      r= new rand
      console.log  ( r.next().toFixed(5) for  [1..5] ).join(', ')

    recreateRandomNumbers = (max=10) ->
      # should the print the same rands, twice
      fiveRandomNumbers()
      fiveRandomNumbers()

## Code

    class rand
      @seed0: 10013
      @mult:  16807
      @mod:   2147483647

With this constructor, if initialized many times using `new rand`
then, each time, it will generate the same sequence of random
numbers.

      constructor: (n = rand.seed0) ->
        @reset(n)

The `reset` method blasts the table and resets the seed.

      reset: (n) ->
        @some = null
        @seed = n % rand.mod

If asked, we can `reset` the seed from the current time.

      fromOS: () ->
        d= new Date()
        @reset( (d.valueOf() * d.getMilliseconds()))

Primitive generator:

      one: () ->
        @seed = (rand.mult * @seed) % rand.mod
        @seed / rand.mod

The generator you should call to get the next random number.  As
is recommended practice, the raw random number generator is wrapped
in a 97 table to increase randomness.

      next: () ->
        @some = @some or (@one() for [1..97])
        x = @one()
        i = Math.floor 97*x
        [ x,@some[i] ] = [ @some[i],x ]
        x

## End

    @rand = rand
    if require.main == module
      fiveRandomNumbers()
      recreateRandomNumbers()
