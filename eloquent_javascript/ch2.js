//chapter 2 Program Structure

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
