//6 The Secret Life of Objects

//A vector type
function Vector(x, y) {
    this.x = x;
    this.y = y;
}

Vector.prototype.length = function() {
    return Math.sqrt(this.x*this.x + this.y*this.y);
};

Vector.prototype.plus = function(other) {
    var o = other || new Vector(0, 0);
    return new Vector(this.x + o.x, this.y + o.y);
};

Vector.prototype.minus = function(other) {
    var o = other || new Vector(0, 0);
    return new Vector(this.x - o.x, this.y - o.y);
};

exports.Vector = Vector;

//Sequence interface
//beigin() 
//next()
//end() 

function logFive(seq) {
    var i = 0;
    seq.begin();
    while(!seq.end() && i < 5) {
	console.log(seq.next());
	i++;
    }
}

exports.logFive = logFive;

function ArraySeq(arr) {
    this.arr = arr;
    this.ndx = 0;
}

ArraySeq.prototype.begin = function() {
    this.ndx = 0;
};

ArraySeq.prototype.next = function() {
    return this.arr[this.ndx++];
};

ArraySeq.prototype.end = function() {
    return this.ndx === this.arr.length;
};

logFive(new ArraySeq([1,2,3,4,5,6,7]));

exports.ArraySeq = ArraySeq;

function RangeSeq(from, to) {
    this.from = from;
    this.to = to;
    this.ndx = from;
}

RangeSeq.prototype.begin = function() {
    this.ndx = this.from;
};

RangeSeq.prototype.next = function() {
    return this.ndx++;
};

RangeSeq.prototype.end = function() {
    return this.ndx > this.to;
};

logFive(new RangeSeq(1, 100));

exports.RangeSeq = RangeSeq;
