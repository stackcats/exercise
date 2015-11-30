//5 Higher-Order Functions

//Flattening
function flatten(arr) {
    return arr.reduce(function(a, b) {
	return a.concat(b);
    }, []);
}

exports.flatten = flatten;

//Mother-child age difference
var ancestry = JSON.parse(require('./ancestry'));

function motherChild() {

    var byName = {};
    ancestry.forEach(function(person) {
	byName[person.name] = person;
    });
    
    var all = 0, num = 0;
    ancestry.forEach(function(each) {
	var mother = byName[each.mother];
	if(mother) {
	    all += each.born - mother.born;
	    num++;
	}
    });

    return num ? all/num : 0 ;
}

console.log(motherChild());

//Historical life expectancy
function average() {
    obj = {};
    ancestry.forEach(function(each) {
	var century = Math.ceil(each.died / 100);
	if(obj[century]){
	    obj[century].all += each.died - each.born;
	    obj[century].num += 1;
	} else {
	    obj[century] = {};
	    obj[century].all = each.died - each.born;
	    obj[century].num = 1;
	}
    });
    
    for(var each in obj){
	var averagePerCentury = obj[each].all / obj[each].num;
	obj[each] = averagePerCentury;
    }
    return obj;
}

console.log(average());

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

