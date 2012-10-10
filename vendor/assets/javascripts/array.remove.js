//= require underscore
// remove an element from the array
Array.prototype.remove = function(element) {
  for(var index = this.indexOf(element); index !== -1; index = _.indexOf(this, element)){
    this.splice(index, 1);
  }
};
