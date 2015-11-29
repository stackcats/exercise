var assert = require('assert');
var obj = require('../ch5');

suite("5 High Order Functions", function() {
    suite("flatten", function() {

	test("flatten([1,2,3]) return [1,2,3]", function() {
	    assert.deepEqual([1,2,3], obj.flatten([1,2,3]));
	});

	test("flatten([[1,2], [3,4]])", function() {
	    assert.deepEqual([1,2,3,4], obj.flatten([[1,2],[3,4]]));
	});

	test("flatten([1,[2,[3,4]],[5,6],7])", function() {
	    var arr = obj.flatten([1,[2,[3,4]],[5,6],7]);
	    assert.deepEqual([1,2,[3,4],5,6,7], arr);
	});

    });

    suite("every", function() {

	test("every([1,3,5])", function() {
	    assert.ok(obj.every([1,3,5], function(n) {
		if(n % 2 == 1)
		    return true;
		else
		    return false;
	    }));
	});

	test("every([1,2,3])", function() {
	    assert.equal(false,
			 obj.every([1,2,3], function(n) {
			     if(n % 2 == 0)
				 return true;
			     return false;
			 }));

	});


	test("some([0,3,4])", function() {
	    assert.ok(obj.some([0,3,4], function(n) {
		if(n % 2 == 1)
		    return true;
		else
		    return false;
	    }));
	});

	test("some([1,3,5])", function() {
	    assert.ok(!obj.every([1,3,5], function(n) {
		if(n % 2 == 0)
		    return true;
		else
		    return false;
	    }));
	});

    });

});
