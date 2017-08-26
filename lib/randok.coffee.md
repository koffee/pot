2222

    require './our'
    r0= require './rand' 
 
    r= new r0.rand
    r.fromOS()
    for [1..10**1]
      console.log(r.next())
