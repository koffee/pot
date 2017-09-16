[home](http://tiny.cc/koff) |
[copyright](https://github.com/koffee/script/blob/master/LICENSE.md) &copy;2017, tim&commat;menzies.us<br>
[<img width=900 src=https://raw.githubusercontent.com/koffee/script/master/img/head.jpg>](http://tiny.cc/koff)<br>
[src](https://github.com/koffee/script/tree/master/lib) |
[tour](https://github.com/koffee/script/blob/master/docs/TOUR.md) |
[style](https://github.com/koffee/script/blob/master/docs/STYLE.md) 

<img src="http://www.backcountryengineering.com/wp-content/uploads/2016/11/workinprogress1.jpg" align=right width=400>


<em>(This code ports and extends
[lualure](https://lualure.github.io/info/). Work in progress. Check back in sometime in October'17.)</em>

# README 

Optimizers explore a landscape looking for pathways to better solutions.
Data miners summarize landscapes. So why not combine them?

Turns out, this is a very useful strategy.
Recently we've had much success using "data miners" as sub-routines to achieve tasks like planning
[[1]](https://arxiv.org/pdf/1609.03614.pdf), [[2]](https://arxiv.org/pdf/1708.05442.pdf) and
multi-opbjective optimization [[3]](https://arxiv.org/pdf/1705.05018.pdf). The resulting
systems are blazzing fast, generate succinct models, and offer novel services that are unsupported by most other optimizer/data miners.

But there is no reference implementation contain all these ideas  in one place. 
To fix that, I started [lualure](https://lualure.github.io/info/)
and that looked promising. However...

- After a month of writing `local` in front of everything... 
- And after reading worrying things about fragmentation of the LUA community [(in particular, about LUAJIT)](https://realmensch.org/2016/05/28/goodbye-lua/)...

... I went looking for another implementation method. I 
dabbled in Coffeescript back in 2010 and was afraid it would be a temporary
fad.
But since then:

- The [coffeescript changelog](http://coffeescript.org/v2/#changelog)  remains active and healthy;
- And the [language  keeps being updated](http://coffeescript.org/v2/#coffeescript-2);

Also:

- The Coffeescript language [is just so sane](http://coffeescript.org/) and [succinct](lib/rand.coffee.md);
- The literate programming tools in CS are so well integrated into my standard toolchain (Vim and Github) that I
  can't pass that up.

So, I'm porting all the LUA stuff here (plus doing some extensions).
Watch this space. 

## Details

Most of the files in `/lib` have demo suites so running those will show you what they 
can do.

My code needs two magic variables:

- `NODE_PATH` to find the coffeescript modules;
- `Koffee` to point to the root of these directories.

Hemce, my recommeded usage is:

    export Koffee="$PWD"                    # can also be set in .bashrc
    export NODE_PATH="$PWD/lib:$NODE_PATH"  # can also be set in .bashrc
    coffee lib/FILE.coffee.md

Or, if you don't want to set globals in the envrionment:

    NODE_PATH="$PWD/lib:$NODE_PATH" Koffee="$PWD" coffee lib/FILE.coffee.md
