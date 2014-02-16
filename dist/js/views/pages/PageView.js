(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/pages/PageView', ['views/ProtoView'], function(ProtoView) {
    var PageView;
    PageView = (function(_super) {
      __extends(PageView, _super);

      function PageView() {
        return PageView.__super__.constructor.apply(this, arguments);
      }

      PageView.prototype.render = function() {
        PageView.__super__.render.apply(this, arguments);
        !this.isNoPageAnima && this.animateIn();
        return this;
      };

      return PageView;

    })(ProtoView);
    return PageView;
  });

}).call(this);
