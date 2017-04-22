function patternCount(text, pattern) {
    count = 0;
    for(i = 0; i < text.length-pattern.length; i++) {
        if(text.substring(i, i+pattern.length) == pattern) {
            count++
        }
    }
    return count;
}
function frequentWords(text, k) {
    let patterns = [];
    let count = [];
    for(let i = 0; i < text.length-k; i++) {
        let cur = text.substring(i, i+k);
        count[i] = patternCount(text, cur);
    }
    let maxCount = Math.max(...count);
    for(let i = 0; i < text.length-k; i++) {
        let cur = text.substring(i, i+k);
        if(count[i] == maxCount) {
            patterns.push(cur);
        }
    }
    console.log(patterns)
    return Array.from(new Set(patterns));
}

var res = frequentWords('CGGAGGACTCTAGGTAACGCTTATCAGGTCCATAGGACATTCA',3)

console.log(res.join(' '))
