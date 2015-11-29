//chapter 3 Function


//Minimum
function minimun(a, b) {
    return a < b ? a : b;
}

exports.minimun = minimun;

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

exports.isEven = isEven;

//Bean counting
function countChar(str, ch) {
    var cts = 0;
    for(var i = 0; i < str.length; i++) {
	if(str.charAt(i) === ch)
	    cts++;
    }

    return cts;
}

exports.countChar = countChar;

function countBs(str) {
    return countChar(str, "B");
}

exports.countBs = countBs;
