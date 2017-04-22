var fs = require('fs');


var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});


function hamming(s1, s2) {
    var distance = 0;
    for(let i = 0; i < s1.length; i++) {
        if(s1[i] != s2[i]) {
            distance++;
        }
    }
    return distance;
}

var pattern, str, d, i=0;
rl.on('line', function(line) {
    if(i==0) pattern = line;
    else if(i ==1) str = line;
    else if(i==2) d = +line;
    i++
});
rl.on('close', function() {
    var matches=[];
    for(let i = 0; i < str.length-pattern.length+1; i++) {
        var sub = str.substring(i, i+pattern.length);
        var dist = hamming(sub, pattern);
        if(dist<=d) {
            matches.push(i);
        }
    }


    console.log(matches.length)
})



