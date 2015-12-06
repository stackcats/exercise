var assert = require('assert');
var obj = require('../ch6.js');
var Vector = obj.Vector;
var ArraySeq = obj.ArraySeq;
var RangeSeq = obj.RangeSeq;

suite("6 The Secret Life of Objects", function() {
    suite("A Vector Type", function() {
	test("new Vector(1,2)", function() {
	    var v = new Vector(1,2);
	    assert.equal(1, v.x);
	    assert.equal(2, v.y);
	    assert.equal(Math.sqrt(1*1+ 2*2), v.length());
	});

	test("vector plus and minus", function() {
	    var a = new Vector(1,2);
	    var b = a.plus();
	    assert.equal(1, b.x);
	    assert.equal(2, b.y);
	    b = a.minus();
	    assert.equal(1, b.x);
	    assert.equal(2, b.y);
	    b = new Vector(10, 20);
	    var c = a.plus(b);
	    assert.equal(11, c.x);
	    assert.equal(22, c.y);
	    c = a.minus(b);
	    assert.equal(-9, c.x);
	    assert.equal(-18, c.y);
	});

    });


    suite("Sequence interface", function() {

	test("ArraySeq", function() {
	    var arr = [1,2,3,4,5,6,7,8,9,10];
	    var aseq = new ArraySeq(arr);
	    aseq.begin();
	    arr.forEach(function(n) {
		assert.equal(n, aseq.next());
	    });
	    assert.ok(aseq.end());
	});

	test("RangeSeq", function() {
	    var from = -100, to = 100;
	    var rseq = new RangeSeq(from, to);
	    rseq.begin();
	    while(from <= to) {
		assert.equal(from, rseq.next());
		from++;
	    }
	    assert.ok(rseq.end());
	});

    });

});

