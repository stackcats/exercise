var assert = require('assert');
var obj = require('../ch4');

suite("4 Data Structures: Objects and Arrays", function() {
    suite("range", function() {

	test("range(1, 10) return [1,2,3,4,5,6,7,8,9,10]", function() {
	    var arr = obj.range(1, 10);
	    var tmp = [1,2,3,4,5,6,7,8,9,10];
	    assert.deepEqual(arr, tmp);
	});

	test("range(1, 10, 2) return [1,3,5,7,9]", function() {
	    var arr = obj.range(1, 10, 2);
	    var tmp = [1,3,5,7,9];
	    assert.deepEqual(arr, tmp);

	});

	test("range(10, 1, -2) return [10,8,6,4,2]", function() {
	    var arr = obj.range(10, 1, -2);
	    var tmp = [10,8,6,4,2];
	    assert.deepEqual(arr, tmp);

	});

	test("range(10, 1, 2) return []", function() {
	    var arr = obj.range(10, 1, 2);
	    var tmp = [];
	    assert.deepEqual(arr, tmp);

	});

	test("range(1, 10, -2) return []", function() {
	    var arr = obj.range(1, 10, -2);
	    var tmp = [];
	    assert.deepEqual(arr, tmp);

	});

    });

    suite("sum", function() {

	test("sum(range(1,10)) return 55", function() {
	    assert.equal(55, obj.sum(obj.range(1, 10)));
	});

	test("sum(range(1,10,-1)) return 0", function() {
	    assert.equal(0, obj.sum(obj.range(1, 10, -1)));
	});
	
    });

    suite("reversearray", function() {

	test("reverseArray([1,3,5]) return [5,3,1]", function() {
	    var arr = [1,3,5];
	    assert.deepEqual([5,3,1], obj.reverseArray(arr));
	    assert.deepEqual([1,3,5], arr);
	});

	test("reverseArray([]) return []", function() {
	    assert.deepEqual([], obj.reverseArray([]));
	});

	test("reverseArrayInPlace([1,3,5]) modify arr to [5,3,1]", function() {
	    var arr = [1,3,5];
	    obj.reverseArrayInPlace(arr);
	    assert.deepEqual([5,3,1], arr);
	});

	test("reverseArrayInPlace([1,2,3,4]) modify arr to [4,3,2,1]", function() {
	    var arr = [1,2,3,4];
	    obj.reverseArrayInPlace(arr);
	    assert.deepEqual([4,3,2,1], arr);
	});

	test("reverseArrayInPlace([]) do nothing", function() {
	    var arr = [];
	    obj.reverseArrayInPlace(arr);
	    assert.deepEqual([], arr);
	});


    });

    suite("A List", function() {

	test("arrayToList([1,2,3])", function() {
	    var l = obj.arrayToList([1,2,3]);
	    assert.equal("( 3 2 1 )", String(l));
	});

	test("arrayToList([])", function() {
	    var l = obj.arrayToList([]);
	    assert.equal("( )", String(l));
	});

	test("listToArray", function() {
	    var l = obj.arrayToList([1,2,3]);
	    
	    var a = obj.listToArray(l);
	    assert.deepEqual([1,2,3], a);
	});

	test("nth", function() {
	    var l = obj.arrayToList([1,2,3]);
	    assert.equal(3, obj.nth(l, 0));
	    assert.equal(1, obj.nth(l, 2));
	    assert.equal(2, obj.nth(l, 1));
	    assert.ok(!obj.nth(l, -1));
	    assert.ok(!obj.nth(l, 10));
	});

	test("nthr", function() {
	    var l = obj.arrayToList([1,2,3]);
	    assert.equal(3, obj.nthr(l, 0));
	    assert.equal(1, obj.nthr(l, 2));
	    assert.equal(2, obj.nthr(l, 1));
	    assert.ok(!obj.nthr(l, -1));
	    assert.ok(!obj.nthr(l, 10));
	});

    });

});

