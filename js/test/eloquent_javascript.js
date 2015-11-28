var assert = require('assert');
var eloquent = require('../eloquent_javascript');

suite('eloquent javascript', function() {

    suite('minimum', function() {

	test("minimum(1, 10) return 1", function() {
	    assert.equal(1, eloquent.minimun(1, 10));
	});

	test("minimum(10, -10) return -10", function() {
	    assert.equal(-10, eloquent.minimun(10, -10));
	});
    });

    suite('isEven', function() {

	test("isEven(50) return true", function() {
	    assert.equal(true, eloquent.isEven(50));
	});

	test("isEven(75) return false", function() {
	    assert.equal(false, eloquent.isEven(75));
	});

	test("isEven(-50) return true", function() {
	    assert.equal(true, eloquent.isEven(-50));
	});

	test("isEven(-75) return false", function() {
	    assert.equal(false, eloquent.isEven(-75));
	});
    });

    suite('countchar', function() {

	test('countchar("aaa", "a") return 3', function() {
	    assert.equal(3, eloquent.countChar("aaa", "a"));
	});

	test('countchar("aaa", "b") return 0', function() {
	    assert.equal(0, eloquent.countChar("aaa", "b"));
	});

	test('countchar("abcdefgfedcba", "e") return 2', function() {
	    assert.equal(2, eloquent.countChar("abcdefgfedcba", "e"));
	});

	test('countBs("Beans Beaf") return 2', function() {
	    assert.equal(2, eloquent.countBs("Beans Beaf"));
	});
    });

    suite("range", function() {

	test("range(1, 10) return [1,2,3,4,5,6,7,8,9,10]", function() {
	    var arr = eloquent.range(1, 10);
	    var tmp = [1,2,3,4,5,6,7,8,9,10];
	    assert.deepEqual(arr, tmp);
	});

	test("range(1, 10, 2) return [1,3,5,7,9]", function() {
	    var arr = eloquent.range(1, 10, 2);
	    var tmp = [1,3,5,7,9];
	    assert.deepEqual(arr, tmp);

	});

	test("range(10, 1, -2) return [10,8,6,4,2]", function() {
	    var arr = eloquent.range(10, 1, -2);
	    var tmp = [10,8,6,4,2];
	    assert.deepEqual(arr, tmp);

	});

	test("range(10, 1, 2) return []", function() {
	    var arr = eloquent.range(10, 1, 2);
	    var tmp = [];
	    assert.deepEqual(arr, tmp);

	});

	test("range(1, 10, -2) return []", function() {
	    var arr = eloquent.range(1, 10, -2);
	    var tmp = [];
	    assert.deepEqual(arr, tmp);

	});

    });

    suite("sum", function() {

	test("sum(range(1,10)) return 55", function() {
	    assert.equal(55, eloquent.sum(eloquent.range(1, 10)));
	});

	test("sum(range(1,10,-1)) return 0", function() {
	    assert.equal(0, eloquent.sum(eloquent.range(1, 10, -1)));
	});
	
    });

    suite("reversearray", function() {

	test("reverseArray([1,3,5]) return [5,3,1]", function() {
	    var arr = [1,3,5];
	    assert.deepEqual([5,3,1], eloquent.reverseArray(arr));
	    assert.deepEqual([1,3,5], arr);
	});

	test("reverseArray([]) return []", function() {
	    assert.deepEqual([], eloquent.reverseArray([]));
	});

	test("reverseArrayInPlace([1,3,5]) modify arr to [5,3,1]", function() {
	    var arr = [1,3,5];
	    eloquent.reverseArrayInPlace(arr);
	    assert.deepEqual([5,3,1], arr);
	});

	test("reverseArrayInPlace([1,2,3,4]) modify arr to [4,3,2,1]", function() {
	    var arr = [1,2,3,4];
	    eloquent.reverseArrayInPlace(arr);
	    assert.deepEqual([4,3,2,1], arr);
	});

	test("reverseArrayInPlace([]) do nothing", function() {
	    var arr = [];
	    eloquent.reverseArrayInPlace(arr);
	    assert.deepEqual([], arr);
	});


    });

    suite("A List", function() {

	test("arrayToList([1,2,3])", function() {
	    var l = eloquent.arrayToList([1,2,3]);
	    assert.equal("( 3 2 1 )", String(l));
	});

	test("arrayToList([])", function() {
	    var l = eloquent.arrayToList([]);
	    assert.equal("( )", String(l));
	});

	test("listToArray", function() {
	    var l = eloquent.arrayToList([1,2,3]);
	    
	    var a = eloquent.listToArray(l);
	    assert.deepEqual([1,2,3], a);
	});

	test("nth", function() {
	    var l = eloquent.arrayToList([1,2,3]);
	    assert.equal(3, eloquent.nth(l, 0));
	    assert.equal(1, eloquent.nth(l, 2));
	    assert.equal(2, eloquent.nth(l, 1));
	    assert.ok(!eloquent.nth(l, -1));
	    assert.ok(!eloquent.nth(l, 10));
	});

	test("nthr", function() {
	    var l = eloquent.arrayToList([1,2,3]);
	    assert.equal(3, eloquent.nthr(l, 0));
	    assert.equal(1, eloquent.nthr(l, 2));
	    assert.equal(2, eloquent.nthr(l, 1));
	    assert.ok(!eloquent.nthr(l, -1));
	    assert.ok(!eloquent.nthr(l, 10));
	});

    });


});

