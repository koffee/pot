[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.png>](http://tiny.cc/koffeed)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 







# Literate CoffeeScript

## This is a first example of writing a markdown file with literate coffeescript

[Literate coffeescript](http://coffeescript.org/#literate), let you
mix Markdown syntax with plain coffeescript.

    memoize = (func) ->
      memo = {}
      (arg) ->
        memo[arg] = func arg unless memo[arg]
        memo[arg]

    fibonacci = (n) ->
      if   n < 2
      then 1
      else fibonacci(n-1) + fibonacci(n-2)

    fibonacci = memoize fibonacci

    for n in [1..100]
      console.log "fibonacci(#{n}) => #{fibonacci(n)}"
    
## It's funny as any code block are executed in order.

I can easly write like this to produce things like 

* Documentation
* Coding manuals
* API documentation
* Tutorials

I don't see that's it *that* usefull for everyday code : your code
should *express* itself without needing much documentation.  And
for the record currently my editor, is completly lost on syntax
highligting

