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
