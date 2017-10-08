src   = process.env.PWD + "/../src/" 
#{say,want,ninf,inf,max,abs} = require src+'our'
{Rand} = require src+'rand'
{Num} = require src+'num'
         
eg3 = (near=0.1)->
 r=new Rand(1)
 [n1,n2] = [new Num, new Num]
 for i in [1..20]
    s = r.next()
    n1.add i
    n2.add i + s*near
 console.log ">>>",(n1.ttest n2)

eg3s = ->
  for near in [0.1,0.2,0.4,0.8]
    console.log near
    eg3(near)

for f in [eg3s]
  console.log f
  f()
