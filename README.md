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

## What (is this code)?

Optimizers explore a landscape looking for pathways to better solutions.
Data miners summarize landscapes. So why not combine them?

Turns out, this is a very useful strategy.
Recently we've had much success using "data miners" as sub-routines to achieve tasks like planning
[[1]](https://arxiv.org/pdf/1609.03614.pdf), [[2]](https://arxiv.org/pdf/1708.05442.pdf) and
multi-opbjective optimization [[3]](https://arxiv.org/pdf/1705.05018.pdf). The resulting
systems are blazzing fast, generate succinct models, and offer novel services that are unsupported by most other optimizer/data miners.

But there is no reference implementation contain all these ideas  in one place. 
Hence, this work.

## How (to run this code)?

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
    
## Why (Coffeescript)?

This code began as a 
[lua](https://lualure.github.io/info/) prototype
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

Also, I asked [Geoffrey Booth](https://github.com/GeoffreyBooth) about the health of CoffeeScript and his reply convinced
me that this was a viable approach:

- Hi Tim,     
  CoffeeScript is “just JavaScript,” as the docs say, so in some
  sense it’s part of the JavaScript ecosystem just like ES6 through
  ES2017 are and TypeScript is. When new features are added to ES,
  unless they require new syntax (and most don’t), they’re available
  for use in CoffeeScript automatically. CoffeeScript and JavaScript
  aren’t separate languages, in the traditional sense; if anything,
  CoffeeScript is a dialect of JavaScript. CoffeeScript code can
  import and export JavaScript modules and classes, and even contain
  blocks of inline JavaScript code. It’s a misperception to think
  of CoffeeScript and JavaScript as separate competing languages;
  there’s really just one language, JavaScript, and CoffeeScript
  is merely an alternate syntax for it.
- A few parts of the ecosystem are split based on syntax, though.
CoffeeScript’s linter, Coffeelint, is well behind ESLint; hopefully
now that CoffeeScript 2 is out, Coffeelint will get some updating,
but Coffeelint can’t handle some of the newest features of CoffeeScript2.
But CoffeeScript’s
ecosystem isn’t as robust; nor will it ever be, since by definition
CoffeeScript will always be smaller than JavaScript (though JavaScript
is huge). CoffeeScript does have excellent integration with build
tools like Webpack and Gulp and Grunt and Browserify, and source
maps work just as well as Babel’s do, and most editors and IDEs
have syntax highlighting and other support for CoffeeScript. So
it’s certainly popular enough to be viable, I would say, if not as
well-supported as JavaScript.  
- So it’s really up to you. The
biggest reason not to use CoffeeScript today is because it’s not
as popular as standard JavaScript, if you’re looking to attract
contributors to a project or future employees to a company. I think
the sweet spot where it makes the most sense is for projects where
the developers starting a project are likely to see it through to
the end, and they honestly prefer the syntax over plain JavaScript.
At this point it’s mostly a matter of personal preference: either
you prefer the Ruby/Python-like syntax over JS, or you hate it. If
you prefer it, and you’re not worried about possibly turning off
developers who would shy away from working in CoffeeScript, then
go for it.
- The worst that can happen is that at some point you might
decide to convert your project into JavaScript, and there are
automated tools to do so: CoffeeScript’s own compiler itself outputs
human-readable JS including your comments, and there are tools like
Decaffeinate that attempt to go further in making that generated
JavaScript look more like idiomatic ES6. Unlike a truly separate
language, CoffeeScript doesn’t lock you in.  
- Best of luck with your project,         
  Geoffrey



