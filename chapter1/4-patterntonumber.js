var map = {0: 'a', 1:'c', 2:'g', 3: 't'};
var revmap = {'a':0, 'c':1, 'g':2, 't':3};



function patternToNumber(pattern) {
    if(pattern == '') {
        return 0;
    } else {
        symbol = pattern.slice(-1);
        prefix = pattern.slice(0, -1);
        console.log('val',revmap[symbol.toLowerCase()],prefix);
        return revmap[symbol.toLowerCase()]+4*patternToNumber(prefix);
    }
}

console.log(patternToNumber('AATCCCATTCATAAGGAT'));
