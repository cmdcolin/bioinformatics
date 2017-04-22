var fs = require('fs');
var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

var i = 0;
var s1;
var s2;

rl.on('line', function(line){
    if(i==0) s1 = line;
    else if(i==1) {
        s2 = line;
        var distance = 0;
        for(let i = 0; i < s1.length; i++) {
            if(s1[i] != s2[i]) {
                distance++;
            }
        }
        console.log(distance)
    }
    i++;
})
