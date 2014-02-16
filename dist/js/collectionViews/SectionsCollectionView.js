(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collectionViews/SectionsCollectionView', ['collectionViews/ProtoCollectionView', 'views/SectionView', 'helpers'], function(ProtoView, SectionView, helpers) {
    var SectionsCollectionView;
    SectionsCollectionView = (function(_super) {
      __extends(SectionsCollectionView, _super);

      function SectionsCollectionView() {
        return SectionsCollectionView.__super__.constructor.apply(this, arguments);
      }

      SectionsCollectionView.prototype.itemView = SectionView;

      SectionsCollectionView.prototype.template = '#sections-collection-view-template';

      SectionsCollectionView.prototype.render = function() {
        _.defer((function(_this) {
          return function() {
            SectionsCollectionView.__super__.render.apply(_this, arguments);
            return _this.$el.addClass('animated fadeInDown');
          };
        })(this));
        return this;
      };

      return SectionsCollectionView;

    })(ProtoView);
    return SectionsCollectionView;
  });

}).call(this);
