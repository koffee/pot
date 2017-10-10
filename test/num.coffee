src   = process.env.PWD + "/../src/" 
#{say,want,ninf,inf,max,abs} = require src+'our'
{Rand} = require src+'rand'
{Num} = require src+'num'
         
eg4s = ->
  near=1
  while near < 2
    eg4(near)
    near *= 1.05

abs=(x) -> if x < 0 then x*-1 else x

cliffs = (p,q,small=0.147) ->
  # takes 1/100th of a sec for 1,000 items
  # takes half    of a sec for 10,000 items
  # takes a minute         for 100,000 items so if your lists
  # get big, sort q then do a binary search for items in p in q
  lt=gt=0
  for x in p
    for y in q
      if y > x then gt++
      if y < x then lt++
  abs(gt - lt)/ (p.length * q.length) < small

eg4= (x=1,
      p=[10,  20,  30,  40,  50,  60,  70,  80],
      q=[11,  21,  31,  41,  51,  61,  71,  81]) ->
  r= (q1*x for  q1 in q)
  [n1,n2,n3] = [new Num, new Num,new Num]
  n1.adds p
  n2.adds q
  n3.adds r
  console.log x.toFixed(3),"base",(n1.ttest n2), "t12",(n1.ttest n3), "same13",(n1.same n3),"cliffs",cliffs(p,r)

eg5 = ->
  for i in [100,1000,10000]
    r=new Rand(1)
    lst1 = (r.next() for _  in [1..i])
    lst2 = (r.next() for _  in [1..i])
    t1=  (new Date).getTime()
    x= cliffs(lst1,lst2)
    t2=  (new Date).getTime()
    console.log i, x, (t2-t1)/1000, 'seconds'

for f in [eg4s,eg5]
  console.log f
  f()
