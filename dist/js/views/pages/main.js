(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/pages/main', ['views/pages/PageView', 'views/IconSelectView', 'models/IconSelectModel', 'underscore', 'hammer', 'tween', 'helpers'], function(PageView, IconSelectView, IconSelectModel, _, hammer, TWEEN, helpers) {
    var Main;
    Main = (function(_super) {
      __extends(Main, _super);

      function Main() {
        return Main.__super__.constructor.apply(this, arguments);
      }

      Main.prototype.template = '#main-template';

      Main.prototype.className = "cf";

      Main.prototype.events = {
        'click .js-download': 'download'
      };

      Main.prototype.initialize = function(o) {
        this.o = o != null ? o : {};
        this.isNoPageAnima = true;
        Main.__super__.initialize.apply(this, arguments);
        return this;
      };

      Main.prototype.render = function() {
        Main.__super__.render.apply(this, arguments);
        this.iconSelectView = new IconSelectView({
          model: new IconSelectModel,
          $el: this.$('#js-icons-select-view-place'),
          isRender: true,
          pageNum: this.o.pageNum
        });
        this.$mainLogo = this.$('.main-logo-b');
        this.$melon = this.$('.logo-large-e');
        this.$mainSection = this.$('#js-icons-select-view-place');
        this.$browserIcons = this.$mainLogo.find('#js-browsers-icons');
        _.defer((function(_this) {
          return function() {
            !App.mainAnimated && _this.animate();
            return App.mainAnimated && _this.show();
          };
        })(this));
        this.hammerTime();
        return this;
      };

      Main.prototype.hammerTime = function() {
        var $el, deg, hamerTime, prefix;
        $el = this.$('#js-main-logo-icon');
        hamerTime = $el.hammer();
        this.maxDeg = 20;
        deg = 0;
        prefix = helpers.prefix();
        hamerTime.on('drag', (function(_this) {
          return function(e) {
            TWEEN.removeAll();
            deg = e.gesture.deltaX;
            deg = _this.sliceDeg(deg);
            return $el.css("" + prefix + "transform", "rotate(" + deg + "deg)");
          };
        })(this));
        hamerTime.on('touch', (function(_this) {
          return function(e) {
            deg = -($el.position().left + ($el.outerWidth() / 2) - e.gesture.center.pageX);
            return deg = _this.sliceDeg(deg);
          };
        })(this));
        return hamerTime.on('release', (function(_this) {
          return function(e) {
            var twn;
            twn = new TWEEN.Tween({
              amount: deg
            }).to({
              amount: 0
            }, 2000).easing(function(t) {
              var b;
              b = Math.exp(-t * 5) * Math.cos(Math.PI * 2 * t * 5);
              return 1 - b;
            }).onUpdate(function() {
              return $el.css("" + prefix + "transform", "rotate(" + this.amount + "deg)");
            }).start();
            twn.start();
            return !_this.animateStarted && _this.animateTween();
          };
        })(this));
      };

      Main.prototype.sliceDeg = function(deg) {
        deg = deg > this.maxDeg ? this.maxDeg : deg;
        return deg = deg < -this.maxDeg ? -this.maxDeg : deg;
      };

      Main.prototype.animateTween = function() {
        this.animateStarted = true;
        requestAnimationFrame((function(_this) {
          return function() {
            return _this.animateTween();
          };
        })(this));
        return TWEEN.update();
      };

      Main.prototype.download = function() {
        if (App.iconsSelected.length === 0) {
          App.notifier.show({
            type: 'error',
            text: 'select at least one icon to download'
          });
          return;
        }
        this.$downloadBtn = this.$('.js-download');
        this.$downloadBtn.addClass('loading-eff');
        return $.ajax({
          type: 'post',
          url: '/download-icons',
          data: {
            icons: App.iconsSelected,
            filters: App.filtersSelected
          },
          success: function(filename) {
            return location.href = "/generated-icons/" + filename + ".zip";
          },
          error: function(e) {
            return console.error(e);
          },
          complete: (function(_this) {
            return function() {
              return _this.$downloadBtn.removeClass('loading-eff');
            };
          })(this)
        });
      };

      Main.prototype.animate = function() {
        this.$mainLogo.addClass('animated fadeInRightBig');
        this.$melon.addClass('animated swing');
        return setTimeout((function(_this) {
          return function() {
            _this.$mainSection.addClass('animated fadeInDown');
            _this.animateIcons();
            return App.mainAnimated = true;
          };
        })(this), 1000);
      };

      Main.prototype.animateIcons = function() {
        return this.$browserIcons.addClass('animated fadeInDown');
      };

      Main.prototype.show = function() {
        this.$mainLogo.addClass('is-no-translateX');
        this.$melon.removeClass('is-rotated');
        this.$mainSection.addClass('animated fadeInDown');
        return this.$mainLogo.addClass('animated fadeInDown');
      };

      Main.prototype.teardown = function() {
        this.iconSelectView.teardown();
        Main.__super__.teardown.apply(this, arguments);
        return this;
      };

      return Main;

    })(PageView);
    return Main;
  });

}).call(this);
