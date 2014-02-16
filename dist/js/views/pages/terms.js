(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/pages/terms', ['views/pages/PageView'], function(PageView) {
    var Terms;
    Terms = (function(_super) {
      __extends(Terms, _super);

      function Terms() {
        return Terms.__super__.constructor.apply(this, arguments);
      }

      Terms.prototype.template = '#terms-page-template';

      Terms.prototype.className = 'terms-p';

      return Terms;

    })(PageView);
    return Terms;
  });

}).call(this);
