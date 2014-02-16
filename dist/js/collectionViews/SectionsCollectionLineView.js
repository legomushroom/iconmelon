(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collectionViews/SectionsCollectionLineView', ['collectionViews/ProtoCollectionView', 'views/SectionLineView'], function(ProtoView, SectionLineView) {
    var SectionsCollectionView;
    SectionsCollectionView = (function(_super) {
      __extends(SectionsCollectionView, _super);

      function SectionsCollectionView() {
        return SectionsCollectionView.__super__.constructor.apply(this, arguments);
      }

      SectionsCollectionView.prototype.itemView = SectionLineView;

      SectionsCollectionView.prototype.template = '#sections-collection-line-view-template';

      SectionsCollectionView.prototype.appendHtml = function(collectionView, itemView, i) {
        return this.$('#js-icons-place').append(itemView.el);
      };

      return SectionsCollectionView;

    })(ProtoView);
    return SectionsCollectionView;
  });

}).call(this);
