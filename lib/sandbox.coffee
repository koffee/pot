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
