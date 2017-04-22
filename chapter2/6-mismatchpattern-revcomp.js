var fs = require('fs');


const nuc = ['A','C','G','T'];
const map = {0: 'A', 1:'C', 2:'G', 3: 'T'};
const revmap = {'A':0, 'C':1, 'G':2, 'T':3};
const match={'a': 'T', 'A': 'T', 't': 'A', 'T': 'A', 'g': 'C', 'G': 'C', 'c': 'G', 'C': 'G'};

function reverse(seq) {
    var o = '';
    for (var i = seq.length - 1; i >= 0; i--) {
        o += seq[i].toUpperCase();
    }
    return o;
}
function complement(seq) {
    var o = '';
    for (var i = 0; i < seq.length; i++) {
        if (match[seq[i]] == undefined) break;
        o += match[seq[i]].toUpperCase();
    }
    return o;
}
function revcom(seq) {
    var o = '';
    for (var i = seq.length - 1; i >= 0; i--) {
        if (match[seq[i]] == undefined) break;
        o += match[seq[i]];
    }
    return o;
}

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
        ret += revmap[text[i]] * (4**pow);
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
        let str2 = revcom(str);
        let neighbors2 = Neighbors(str2, d);
        neighborhoods.add(neighbors2);
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
//    let currmax = 0;
//    let currmaxpat = new Set(); 
//    for(let i = 0; i < neighborhoodArray.length; i++) {
//        let pattern = numberToPattern(sortedIndex[i], k);
//        let reversePattern = revcom(pattern);
//        let j = patternToNumber(reversePattern)
//        let sum = count[i];// + count[j];
//        if(sum > currmax) {
//            currmax = sum;
//            currmaxpat.clear();
//            currmaxpat.add(pattern);
//        } else if(sum == currmax) {
//            currmaxpat.add(pattern);
//        }
//    }
//    return currmaxpat;
    var maxCount = count.reduce(function(a, b) {
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



var str = fs.readFileSync(process.argv[2], 'utf8');
var p = str.split('\n');
var text = p[0];
var k = +p[1].split(' ')[0];
var d = +p[1].split(' ')[1];

var ret = FrequentWordsWithMismatches(text, k, d);
console.log(Array.from(ret).join(' '))
