(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('router', ['backbone', 'controllers/PagesController'], function(B, pc) {
    var Router;
    Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.routes = {
        '': 'main',
        '/:pageNum': 'main',
        'submit': 'submit',
        'editr': 'editr',
        'support-us': 'support',
        'how-to-use': 'how',
        'hire-me': 'hire',
        '*path': 'main'
      };

      Router.prototype.main = function(pageNum) {
        var _ref;
        if (pageNum == null) {
          pageNum = '1';
        }
        pageNum = ((_ref = pageNum.match(/\d/gi)) != null ? _ref[0] : void 0) || 1;
        this.startPage(pc.main, {
          pageNum: ~~pageNum
        });
        this.checkMainMenuItem();
        return this.animateHeader();
      };

      Router.prototype.submit = function() {
        this.startPage(pc.submit);
        this.checkMainMenuItem('#js-submit');
        return this.showHeader();
      };

      Router.prototype.editr = function() {
        this.startPage(pc.editr);
        this.checkMainMenuItem('#js-editr');
        return this.showHeader();
      };

      Router.prototype.support = function() {
        this.startPage(pc.support);
        this.checkMainMenuItem('#js-support-us');
        return this.showHeader();
      };

      Router.prototype.how = function() {
        this.startPage(pc.how);
        this.checkMainMenuItem('#js-how');
        return this.showHeader();
      };

      Router.prototype.hire = function() {
        this.startPage(pc.hire);
        this.checkMainMenuItem('#js-hire');
        return this.showHeader();
      };

      Router.prototype.startPage = function(View, options) {
        var _ref;
        if (options == null) {
          options = {};
        }
        if (this.currentPageView === View) {
          return;
        }
        this.currentPageView = View;
        if ((_ref = this.currentPage) != null) {
          _ref.teardown();
        }
        this.currentPage = new View(options);
        App.main.show(this.currentPage);
        return App.$bodyHtml.animate({
          'scrollTop': 0
        });
      };

      Router.prototype.animateHeader = function() {
        return setTimeout((function(_this) {
          return function() {
            return App.$mainHeader.addClass('animated fadeInDown');
          };
        })(this), 1000);
      };

      Router.prototype.showHeader = function() {
        return App.$mainHeader.css({
          'opacity': 1
        }).addClass('no-animation');
      };

      Router.prototype.checkMainMenuItem = function(selector) {
        return App.$mainHeader.find('a').removeClass('is-check').filter(selector).addClass('is-check');
      };

      return Router;

    })(B.Router);
    return Router;
  });

}).call(this);
