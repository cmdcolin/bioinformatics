function non_tail_recursion(count) {
    if(count == 0) return '';
    return count + ' ' +non_tail_recursion(count-1);
}
function tail_recursion(count) {
    if(count == 0) return '';
    return tail_recursion(count-1) + ' ' + count;
}
console.log(non_tail_recursion(10))
console.log(tail_recursion(10))
