(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/pages/hire', ['views/pages/PageView'], function(PageView) {
    var Hire;
    Hire = (function(_super) {
      __extends(Hire, _super);

      function Hire() {
        return Hire.__super__.constructor.apply(this, arguments);
      }

      Hire.prototype.template = '#hire-page-template';

      Hire.prototype.className = 'hire-p';

      Hire.prototype.render = function() {
        Hire.__super__.render.apply(this, arguments);
        this.loadImage();
        return this;
      };

      Hire.prototype.loadImage = function() {
        var imageObj;
        imageObj = new Image();
        imageObj.onload = (function(_this) {
          return function() {
            return _this.$('#js-lego-img').addClass('animate fadeInUp').removeClass('op-0-gm');
          };
        })(this);
        return imageObj.src = window.devicePixelRatio > 1 ? 'css/i/legomushroom-@2x.png' : 'css/i/legomushroom.png';
      };

      return Hire;

    })(PageView);
    return Hire;
  });

}).call(this);
