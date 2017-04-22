function patternCount(text, pattern) {
    count = 0;
    for(i = 0; i < text.length-pattern.length; i++) {
        if(text.substring(i, i+pattern.length) == pattern) {
            count++
        }
    }
    return count;
}
function frequentWords(text, k, t) {
    let patterns = [];
    let count = [];
    for(let i = 0; i < text.length-k; i++) {
        let cur = text.substring(i, i+k);
        count[i] = patternCount(text, cur);
    }
    for(let i = 0; i < text.length-k; i++) {
        let cur = text.substring(i, i+k);
        if(count[i] >= t) {
            patterns.push(cur);
        }
    }
    return Array.from(new Set(patterns));
}

function findClumps(text, L, k, t) {
    var set = new Set();
    for(let i = 0; i < text.length - L; i++) {
        console.log(i/text.length);
        var s = text.substring(i, i+L);
        var ret = frequentWords(s, k, t);
        for(let j = 0; j < ret.length; j++) {
            set.add(ret[j]);
        }
    }
    return Array.from(new Set(set));
}
var fs = require("fs");
var filename = "E_coli.txt";
var buf = fs.readFileSync(filename, "utf8");
var res = findClumps(buf, 500, 9, 3)

console.log(res.join(' '))
