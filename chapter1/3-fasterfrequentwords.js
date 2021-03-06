var map = {0: 'a', 1:'c', 2:'g', 3: 't'};
var revmap = {'a':0, 'c':1, 'g':2, 't':3};


function numberToPattern(num, k) {
    var arr = [];
    for(let i = k; i > 0; i--) {
        arr.push(num % 4);
        num = Math.floor(num / 4);
    }
    var ret = arr.map(function(elt) { return map[elt]; }).reverse().join('');
    return ret;
}

function patternToNumber(text) {
    var ret = 0;
    for(let i = 0; i < text.length; i++) {
        var pow = text.length-i-1;
        ret += revmap[text[i].toLowerCase()] * (4**pow);
    }
    return ret;
}


function computingFrequencies(text, k) {
    var freqArr = [];
    for(let i = 0; i < 4**k; i++) {
        freqArr.push(0);
    }
    for(let i = 0; i < text.length-k+1; i++) {
        let pattern = text.substring(i, i+k);
        freqArr[patternToNumber(pattern)]++;
    }
    return freqArr;
}

function fasterFrequentWords(text, k) {
    let frequentPatterns = new Set();
    let frequencyArray = computingFrequencies(text, k);
    console.log(frequencyArray.join(' '))
    let maxCount = Math.max(...frequencyArray);
    console.log(maxCount);
    for(let i = 0; i < 4**k-1; i++) {
        if(frequencyArray[i] == maxCount) {
            let pattern = numberToPattern(i, k);
            console.log(pattern)
            frequentPatterns.add(pattern);
        }
    }
    console.log(frequentPatterns);
    return Array.from(new Set(frequentPatterns));
}

var res = fasterFrequentWords('AAAGGGGGGAGCGATAAGCGTAGTGAGCGATAAAAGGGGGGAGCGATAAAAGGGGGAGCGTAGTCCCTCTCAGCGTAGTGAGCGATAAAAGGGGGAAAGGGGGGAGCGATATGGCCGCTTGGCCGCTGAGCGATAAAAGGGGGAGCGTAGTCCCTCTCCCCTCTCGAGCGATAAAAGGGGGCCCTCTCTGGCCGCTCCCTCTCTGGCCGCTGAGCGATATGGCCGCTCCCTCTCAAAGGGGGGAGCGATAAGCGTAGTAGCGTAGTAGCGTAGTTGGCCGCTAAAGGGGGAAAGGGGGGAGCGATATGGCCGCTCCCTCTCTGGCCGCTTGGCCGCTAGCGTAGTAGCGTAGTAAAGGGGGTGGCCGCTCCCTCTCTGGCCGCTCCCTCTCTGGCCGCTCCCTCTCGAGCGATAAGCGTAGTAGCGTAGTAAAGGGGGGAGCGATATGGCCGCTAGCGTAGTTGGCCGCTAGCGTAGTTGGCCGCTAGCGTAGTTGGCCGCTAGCGTAGTGAGCGATAAAAGGGGGAGCGTAGTAGCGTAGTTGGCCGCTGAGCGATAAGCGTAGTGAGCGATAAAAGGGGGAGCGTAGTAAAGGGGGAGCGTAGTAAAGGGGGAGCGTAGTAAAGGGGGAGCGTAGTAAAGGGGGCCCTCTCTGGCCGCTCCCTCTCAAAGGGGGGAGCGATAGAGCGATACCCTCTCAGCGTAGTTGGCCGCTGAGCGATAGAGCGATAAAAGGGGGGAGCGATAAGCGTAGTTGGCCGCTAGCGTAGTGAGCGATACCCTCTCAAAGGGGGAGCGTAGTTGGCCGCTTGGCCGCTTGGCCGCTAAAGGGGGTGGCCGCTAGCGTAGTAAAGGGGGCCCTCTCCCCTCTC',13);
console.log(res.join(' '));
