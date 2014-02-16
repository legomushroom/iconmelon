(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collections/FiltersCollection', ['backbone', 'models/FilterModel', 'helpers'], (function(_this) {
    return function(B, FilterModel, helpers) {
      var FiltersCollection;
      FiltersCollection = (function(_super) {
        __extends(FiltersCollection, _super);

        function FiltersCollection() {
          return FiltersCollection.__super__.constructor.apply(this, arguments);
        }

        FiltersCollection.prototype.model = FilterModel;

        FiltersCollection.prototype.url = 'filters';

        FiltersCollection.prototype.addSvgFilters = function() {
          var svgString;
          svgString = '';
          this.each(function(filter) {
            return svgString += filter.get('filter').replace(/\<filter/, "<filter id='" + (filter.get('hash')) + "' ");
          });
          return helpers.addToSvg(svgString);
        };

        return FiltersCollection;

      })(B.Collection);
      return FiltersCollection;
    };
  })(this));

}).call(this);
