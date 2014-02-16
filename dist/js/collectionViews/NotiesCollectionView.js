(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collectionViews/NotiesCollectionView', ['collectionViews/ProtoCollectionView', 'collections/NotiesCollection', 'views/NotyView'], function(ProtoCollectionView, NotiesCollection, NotyView) {
    var NotiesCollectionView;
    NotiesCollectionView = (function(_super) {
      __extends(NotiesCollectionView, _super);

      function NotiesCollectionView() {
        return NotiesCollectionView.__super__.constructor.apply(this, arguments);
      }

      NotiesCollectionView.prototype.itemView = NotyView;

      NotiesCollectionView.prototype.template = '#noties-collection-view-template';

      NotiesCollectionView.prototype.initialize = function(o) {
        this.o = o != null ? o : {};
        this.setElement($('#js-notifier-place'));
        this.collection = new NotiesCollection([]);
        NotiesCollectionView.__super__.initialize.apply(this, arguments);
        return this;
      };

      NotiesCollectionView.prototype.appendHtml = function(collectionView, itemView, i) {
        return this.$el.prepend(itemView.el);
      };

      NotiesCollectionView.prototype.show = function(data) {
        var defaults;
        if (data == null) {
          data = {};
        }
        defaults = {
          type: 'ok',
          text: 'evrything is ok',
          delay: 7000
        };
        data = __extends(defaults, data);
        return this.collection.add(data);
      };

      return NotiesCollectionView;

    })(ProtoCollectionView);
    return NotiesCollectionView;
  });

}).call(this);
