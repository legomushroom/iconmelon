(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collections/NotiesCollection', ['backbone', 'models/NotyModel'], (function(_this) {
    return function(B, NotyModel) {
      var NotiesCollection;
      NotiesCollection = (function(_super) {
        __extends(NotiesCollection, _super);

        function NotiesCollection() {
          return NotiesCollection.__super__.constructor.apply(this, arguments);
        }

        return NotiesCollection;

      })(B.Collection);
      return NotiesCollection;
    };
  })(this));

}).call(this);
