var assert = require('assert');
var obj = require('../ch3');

suite("3 Functions", function() {
    suite('minimum', function() {

	test("minimum(1, 10) return 1", function() {
	    assert.equal(1, obj.minimun(1, 10));
	});

	test("minimum(10, -10) return -10", function() {
	    assert.equal(-10, obj.minimun(10, -10));
	});
    });

    suite('isEven', function() {

	test("isEven(50) return true", function() {
	    assert.equal(true, obj.isEven(50));
	});

	test("isEven(75) return false", function() {
	    assert.equal(false, obj.isEven(75));
	});

	test("isEven(-50) return true", function() {
	    assert.equal(true, obj.isEven(-50));
	});

	test("isEven(-75) return false", function() {
	    assert.equal(false, obj.isEven(-75));
	});
    });

    suite('countchar', function() {

	test('countchar("aaa", "a") return 3', function() {
	    assert.equal(3, obj.countChar("aaa", "a"));
	});

	test('countchar("aaa", "b") return 0', function() {
	    assert.equal(0, obj.countChar("aaa", "b"));
	});

	test('countchar("abcdefgfedcba", "e") return 2', function() {
	    assert.equal(2, obj.countChar("abcdefgfedcba", "e"));
	});

	test('countBs("Beans Beaf") return 2', function() {
	    assert.equal(2, obj.countBs("Beans Beaf"));
	});
    });

});

