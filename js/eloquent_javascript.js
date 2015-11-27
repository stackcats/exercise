/*
 * Eloquent JavaScript
 */
var assert = require('assert');

module.exports = {
    loopTriangle: loopTriangle,
    minimun: minimun,
    isEven: isEven,
    countChar: countChar,
    countBs: countBs,
};

/*
 *chapter 2 Program Structure
 */

//Looping a triangle
function loopTriangle(n) {
    function produceSharp(n) {
	var s = '';
	for(var i = 0; i < n; i++)
	    s += '#';
	return s;
    }
    for(var i = 1; i <= n; i++) {
	console.log(produceSharp(i));
    }
}

/*
 *chapter 3 Function
 */

//Minimum
function minimun(a, b) {
    return a < b ? a : b;
}

//Recursion
function isEven(n) {
    if(n < 0)
	return isEven(-n);
    if(n == 0)
	return true;
    if(n == 1)
	return false;
    return isEven(n - 2);
}

//Bean counting
function countChar(str, ch) {
    var cts = 0;
    for(var i = 0; i < str.length; i++) {
	if(str.charAt(i) === ch)
	    cts++;
    }

    return cts;
}

function countBs(str) {
    return countChar(str, "B");
}
