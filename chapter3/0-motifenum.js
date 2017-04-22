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

function MotifEnum(dna, k, d) {
    let patterns = new Set();
    for(let i = 0; i < dna.length-k; i++) {
        var pattern = dna.substring(i, i+k);
        var neighbors = Neighbors(pattern, d);
        for(let j = 0; j < neighbors.size; j++) {
            if(neighbors[j]
        }
    }
}
