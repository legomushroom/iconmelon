(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/ProtoView', ['marionette'], function(M) {
    var ProtoView;
    ProtoView = (function(_super) {
      __extends(ProtoView, _super);

      function ProtoView() {
        return ProtoView.__super__.constructor.apply(this, arguments);
      }

      ProtoView.prototype.initialize = function(o) {
        this.o = o != null ? o : {};
        this.o.$el && this.setElement(this.o.$el);
        ProtoView.__super__.initialize.apply(this, arguments);
        this.o.isRender && this.render();
        return this;
      };

      ProtoView.prototype.animateIn = function() {
        return this.$el.addClass('animated fadeInDown');
      };

      ProtoView.prototype.teardown = function() {
        var _ref, _ref1;
        this.isClosed = true;
        if ((_ref = this.collection) != null) {
          _ref.isClosed = true;
        }
        if ((_ref1 = this.model) != null) {
          _ref1.isClosed = true;
        }
        return this.undelegateEvents();
      };

      return ProtoView;

    })(M.ItemView);
    return ProtoView;
  });

}).call(this);
