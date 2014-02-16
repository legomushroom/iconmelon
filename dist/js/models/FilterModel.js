(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('models/FilterModel', ['models/ProtoModel'], function(ProtoModel) {
    var FilterModel;
    FilterModel = (function(_super) {
      __extends(FilterModel, _super);

      function FilterModel() {
        return FilterModel.__super__.constructor.apply(this, arguments);
      }

      FilterModel.prototype.defaults = {
        iconHash: 'tick-icon'
      };

      FilterModel.prototype.toggleSelected = function() {
        return this.toggleAttr('isSelected');
      };

      return FilterModel;

    })(ProtoModel);
    return FilterModel;
  });

}).call(this);
