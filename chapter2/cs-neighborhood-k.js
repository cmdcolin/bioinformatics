var nuc = ['A','C','G','T'];



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


console.log(Array.from(Neighbors('TGGGGGCAAT', 3)).sort().join('\n'))

