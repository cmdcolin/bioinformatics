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

function numberToPattern(index, k) {
    if(k == 1) {
        return map[index];
    }
    var prefixIndex = Math.floor(index / 4);
    var r = index % 4;
    var symbol = map[r];
    console.log(symbol);
    return numberToPattern(prefixIndex, k - 1) + symbol;
}

console.log(numberToPattern(6377, 11));
