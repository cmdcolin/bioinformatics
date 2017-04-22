var nuc = ['A','C','G','T'];
function ImmediateNeighbors(pattern) {
    var neighborhood = new Set();
    neighborhood.add(pattern)
    for(let i = 0; i < pattern.length; i++) {
        let symbol = pattern[i];
        for(let j = 0; j < nuc.length; j++) {
            if(nuc[j] != symbol) {
                var neighbor = pattern.substring(0, i) + nuc[j]+ pattern.substr(i + 1);
                neighborhood.add(neighbor);
            }
        }
    }
    return neighborhood;
}


console.log(ImmediateNeighbors('AA'))
