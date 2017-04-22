var fs = require('fs');



const nuc = ['A','C','G','T'];
const map = {0: 'A', 1:'C', 2:'G', 3: 'T'};
const revmap = {'A':0, 'C':1, 'G':2, 'T':3};



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
function Neighbors(pattern, d) {
    if(d == 0) {
        return new Set([pattern]);
    }
    if(pattern.length == 1) {
        return new Set(nuc);
    }
    let neighborhood = new Set()
    let suffixNeighbors = Neighbors(pattern.substring(1), d);
    for(text of suffixNeighbors) {
        if(hamming(pattern.substring(1), text) < d) {
            for(x of nuc) {
                neighborhood.add(x+text);
            }
        } else {
            neighborhood.add(pattern[0]+text);
        }
    }
    
    return neighborhood;
}


function patternToNumber(text) {
    var ret = 0;
    for(let i = 0; i < text.length; i++) {
        var pow = text.length-i-1;
        ret += revmap[text[i]] * (Math.pow(4,pow));
    }
    return ret;
}


function numberToPattern(index, k) {
    if(k == 1) {
        return map[index];
    }
    var prefixIndex = Math.floor(index / 4);
    var r = index % 4;
    var symbol = map[r];
    return numberToPattern(prefixIndex, k - 1) + symbol;
}

function FrequentWordsWithMismatches(text, k, d) {
    let frequentPatterns = new Set();
    let neighborhoods = new Set();
    let index = [];
    let count = [];
    for(let i = 0; i < text.length-k; i++) {
        let str = text.substring(i, i+k);
        let neighbors = Neighbors(str, d);
        neighborhoods.add(neighbors);
    }
    if(neighborhoods.size==0) {
        return [text];
    }

    let neighborhoodArray = [];
    //collapse set of sets into an array
    for(let iter of neighborhoods) {
        neighborhoodArray = neighborhoodArray.concat(Array.from(iter));
    }
    for(let i = 0; i < neighborhoodArray.length; i++) {
        let pattern = neighborhoodArray[i];
        index[i] = patternToNumber(pattern);
        count[i] = 1;
    }
    let sortedIndex = index.sort((a, b) => a - b);

    for(let i = 0; i < neighborhoodArray.length-1; i++) {
        if(sortedIndex[i] == sortedIndex[i+1]) {
            count[i+1] = count[i] + 1;
        }
    }
    let maxCount = count.reduce(function(a, b) {
        return Math.max(a, b);
    });
    for(let i = 0; i < neighborhoodArray.length; i++) {
        if(count[i] == maxCount) {
            let pattern = numberToPattern(sortedIndex[i], k);
            frequentPatterns.add(pattern);
        }
    }
    return frequentPatterns;
}


var str, k, d, i=0;
rl.on('line', function(line) {
    if(i==0) str = line;
    else if(i ==1) {
        k = +line.split(' ')[0];
        d = +line.split(' ')[1];
    }
    i++
});
rl.on('close', function() {
    var ret = FrequentWordsWithMismatches(str, k, d);
    console.log(Array.from(ret).join(' '))
})



