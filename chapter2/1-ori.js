var fs = require('fs');
var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});


function stats(str) {
    var m = [];
    var cur = 0;
    m.push(cur)
    for(let i = 0; i < str.length; i++) {
        if(str[i] == 'G') {
            cur++;
        }
        else if(str[i] == 'C') {
            cur--;
        }
        m.push(cur);
    }
    return m;
}


rl.on('line', function(line){
	var ret = stats(line);
	var p = Math.min.apply(0, ret);

	var p = ret.reduce(function(a, e, i) {
		if (e === p)
			a.push(i);
		return a;
	}, []);
	console.log(p.join(' '))
})

