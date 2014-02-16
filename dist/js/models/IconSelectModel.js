(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('models/IconSelectModel', ['models/ProtoModel'], function(ProtoModel) {
    var IconSelectModel;
    IconSelectModel = (function(_super) {
      __extends(IconSelectModel, _super);

      function IconSelectModel() {
        return IconSelectModel.__super__.constructor.apply(this, arguments);
      }

      IconSelectModel.prototype.defaults = {
        selectedCounter: 0
      };

      IconSelectModel.prototype.initialize = function() {
        App.vent.on('icon:select', _.bind(this.refreshCounter, this));
        IconSelectModel.__super__.initialize.apply(this, arguments);
        return this;
      };

      IconSelectModel.prototype.refreshCounter = function() {
        var counter;
        counter = 0;
        return this.set('selectedCounter', App.iconsSelected.length + App.filtersSelected.length);
      };

      return IconSelectModel;

    })(ProtoModel);
    return IconSelectModel;
  });

}).call(this);
