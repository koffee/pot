[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koffee)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

<img src="http://www.backcountryengineering.com/wp-content/uploads/2016/11/workinprogress1.jpg" align=right width=400>


(This code ports and extends
[lualure](https://lualure.github.io/info/). Work in progress. Check back in sometime in October'17.)

# README 

Optimizers explore a landscape looking for pathways to better solutions.
Data miners summarize landscapes. So why not combine them?

Recently we've had much success using "data miners" as sub-routines to achieve tasks like

- Planning: [1](https://arxiv.org/pdf/1609.03614.pdf), [2](https://arxiv.org/pdf/1708.05442.pdf)
- and multi-opbjective optimization: [3](https://arxiv.org/pdf/1705.05018.pdf)


But there is not reference implementation contain all these ideas  in one place. 
To fix that, I started [lua](https://lualure.github.io/info/)
and that looks promising. Hoewever...

- a month of writing `local` in front of everything, 
- after reading some worrying things about fragmentation of the LUA community [(in particular, about LUAJIT)](https://realmensch.org/2016/05/28/goodbye-lua/)

I went looking for another implementation method. I tried coffeescript back in 2010 and was afraid it would be a one-night-stand fad.
However, I was wrong:

- the [coffeescript changelog](http://coffeescript.org/v2/#changelog)  looks healthy;
- and the [language  keeps being update](http://coffeescript.org/v2/#coffeescript-2);

Also:

- Coffeescript is just Javascript so as the JS community improves, so does CS;
- The Coffeescript language [is just so sane](http://coffeescript.org/) and succinct;
- Jekyll has quirks (e.g. slow updates to its cached pages)
  and the literate programming tools in CS are so well integrated into my standard toolchain (Vim and Github).
  Can't pass that up.

Accordingly, I'm moving all the LUA stuff here.  
