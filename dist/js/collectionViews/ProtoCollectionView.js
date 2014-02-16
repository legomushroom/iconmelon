(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collectionViews/ProtoCollectionView', ['marionette', 'views/ProtoView'], function(M) {
    var ProtoCollectionView;
    ProtoCollectionView = (function(_super) {
      __extends(ProtoCollectionView, _super);

      function ProtoCollectionView() {
        return ProtoCollectionView.__super__.constructor.apply(this, arguments);
      }

      ProtoCollectionView.prototype.initialize = function(o) {
        this.o = o != null ? o : {};
        this.o.$el && this.setElement(this.o.$el);
        ProtoCollectionView.__super__.initialize.apply(this, arguments);
        this.o.isRender && this.render();
        return this;
      };

      ProtoCollectionView.prototype.normalizeCollection = function(collectionProto) {
        var i, modelAttr;
        if (this.model) {
          modelAttr = (function() {
            var _results;
            _results = [];
            for (i in modelAttr = this.model.toJSON()) {
              _results.push(modelAttr[i]);
            }
            return _results;
          }).call(this);
          this.collection = new collectionProto(modelAttr);
          modelAttr = null;
          return this.collection.parentCollection = this.model.collection;
        }
      };

      ProtoCollectionView.prototype.teardown = function() {
        var _ref;
        this.isClosed = true;
        return (_ref = this.collection) != null ? _ref.isClosed = true : void 0;
      };

      return ProtoCollectionView;

    })(M.CompositeView);
    return ProtoCollectionView;
  });

}).call(this);
