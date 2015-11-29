//5 Higher-Order Functions

//Flattening
function flatten(arr) {
    return arr.reduce(function(a, b) {
	return a.concat(b);
    }, []);
}

exports.flatten = flatten;

//Mother-child age difference

//Historical life expectancy

//Every and then some
function every(arr, f) {
    for(var i = 0; i < arr.length; i++)
	if(!f(arr[i]))
	    return false;
    return true;
}

exports.every = every;

function some(arr, f) {
    for(var i = 0; i < arr.length; i++)
	if(f(arr[i]))
	    return true;
    return false;
}

exports.some = some;

