/*
 * Eloquent JavaScript
 */

module.exports = {
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

loopTriangle(7);

//FizzBuzz
function fizzbuzz() {
    
    for(i = 1; i <= 100; i++) {
	if(i % 3 == 0 && i % 5 == 0)
	    console.log("FizzBuzz");
	else if(i % 3 == 0)
	    console.log("Fizz");
	else if(i % 5 == 0)
	    console.log("Buzz");
	else
	    console.log(i);
    }
}

fizzbuzz();

//Chess board
function chessBoard(n) {
    function row(col) {
	var s = '';
	var pattern = null;
	if(col % 2 == 0)
	    pattern = '# ';
	else
	    pattern = ' #';
	for(var i = 0; i < n; i += 2) {
	    s += pattern;
	}
	return s;
    }
    for(var i = 0; i < n; i++) {
	console.log(row(i));
    }
}

chessBoard(8);

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
