readline = require 'readline'

rl = readline.createInterface
       input: process.stdin
       output: process.stdout

rl.question 'What do you think of Node.js? ', (answer) -> 
                      console.log(answer)
rl.close();

