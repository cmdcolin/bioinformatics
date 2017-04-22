function patternCount(text, pattern) {
    count = 0;
    for(i = 0; i < text.length-pattern.length; i++) {
        if(text.substring(i, i+pattern.length) == pattern) {
            count++
        }
    }
    return count;
}
function patternizer(text, k) {
    var counts = new Map();
    for(let i = 0; i < text.length-k; i++) {
        let cur = text.substring(i, i+k);
        counts[cur] = patternCount(text, cur);
    }
    return counts;
}

function findClumps(text, L, k, t) {
    var set = new Set();
    var s = text.substring(0, L);
    var counts = patternizer(s, k);
    console.log(counts);

    for(let i = 1; i < text.length - L; i++) {
        var cur = text.substring(i-1, i+k-1);
        counts[cur] = counts[cur]-1;
        var cur2 = text.substring(i+L-k,i+L);
        counts[cur2] = counts[cur2]+1||0;
        for (var key of counts.keys()) {
            if(counts[key] >= t) {
                set.add(counts[key]);
            }
        }
    }
    console.log(set);
    return Array.from(new Set(set));
}
var fs = require("fs");
var filename = "E_coli.txt";
var buf = fs.readFileSync(filename, "utf8");
console.log(buf.substring(0,5))
var res = findClumps(buf, 500, 9, 3)

console.log(res.join(' '))
