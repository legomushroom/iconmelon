(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('models/NotyModel', ['models/ProtoModel'], function(ProtoModel) {
    var NotyModel;
    NotyModel = (function(_super) {
      __extends(NotyModel, _super);

      function NotyModel() {
        return NotyModel.__super__.constructor.apply(this, arguments);
      }

      NotyModel.prototype.defaults = {
        type: 'ok',
        text: ''
      };

      return NotyModel;

    })(ProtoModel);
    return NotyModel;
  });

}).call(this);
