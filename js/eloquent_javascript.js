/*
 * Eloquent JavaScript
 */


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


//chapter 4 Data Structures: Objects and Arrays


//The sum of a range
function range(start, end, step) {
    var st = step || 1;

    function isEnd(a, b) {
	if(st < 0)
	    return a >= b;
	else
	    return a <= b;
    }

    var arr = [];

    for(var i = start; isEnd(i, end); i += st) {
	arr.push(i);
    }

    return arr;
}

exports.range = range;

function sum(arr) {
    var ans = 0;
    for(var i = 0; i < arr.length; i++)
	ans += arr[i];
    return ans;
}

exports.sum = sum;

//Reversing an array
function reverseArray(arr) {
    var a = [];
    for(var i = 0; i < arr.length; i++)
	a.unshift(arr[i]);
    return a;
}

exports.reverseArray = reverseArray;

function reverseArrayInPlace(arr) {
    
    for(var i = 0, j = arr.length - 1; i < j; i++, j--){
	var tmp = arr[i];
	arr[i] = arr[j];
	arr[j] = tmp;
    }

}

exports.reverseArrayInPlace = reverseArrayInPlace;

//A List

function Node(v, rest) {
    this.value = v;
    this.rest = rest;
}

Node.prototype.toString = function() {
    return String(this.value);
};

function List() {
    this.head = null;
}

List.prototype.prepend = function(v) {
    var n = new Node(v, this.head);
    this.head = n;
    return this.head;
};

List.prototype.toString = function() {
    var str = "( ";
    var lst = this.head;
    while(lst) {
	str += lst.value + " ";
	lst = lst.rest;
    }
    str += ")";
    return str;
};

exports.List = List;

function nth(lst, n) {
    if(n < 0)
	return undefined;

    var l = lst.head;
    while(l && n > 0) {
	l = l.rest;
	n--;
    }

    if(l)
	return l.value;
    else
	return undefined;
};

exports.nth = nth;

function nthr(lst, n) {
    //recursion version
    function helper(lst, n) {
	if(n < 0 || !lst)
	    return undefined;
	if(n == 0)
	    return lst.value;
	else
	    return helper(lst.rest, n-1);    
    }

    return helper(lst.head, n);
}

exports.nthr = nthr;

function arrayToList(arr) {
    var lst = new List();
    for(var i = 0; i < arr.length; i++)
	lst.prepend(arr[i]);
    return lst;
}

exports.arrayToList = arrayToList;

function listToArray(lst) {
    var arr = [];
    var l = lst.head;
    while(l) {
	arr.unshift(l.value);
	l = l.rest;
    }
    return arr;
}

exports.listToArray = listToArray;


//chapter 5  Higher-Order Functions
