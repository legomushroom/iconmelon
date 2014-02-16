(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/pages/editr', ['views/pages/PageView', 'views/EditCollectionView', 'models/SectionModel', 'collections/SectionsCollection', 'collectionViews/SectionsCollectionLineView'], function(PageView, EditCollectionView, IconsCollectionModel, SectionsCollection, SectionsCollectionView) {
    var Edit;
    Edit = (function(_super) {
      __extends(Edit, _super);

      function Edit() {
        return Edit.__super__.constructor.apply(this, arguments);
      }

      Edit.prototype.template = '#editr-page-template';

      Edit.prototype.render = function() {
        Edit.__super__.render.apply(this, arguments);
        this.renderEditCollectionView();
        this.renderCollectionsLine();
        return this;
      };

      Edit.prototype.renderCollectionsLine = function() {
        this.collectionLine = new SectionsCollectionView({
          $el: this.$('#js-collection-line-place'),
          isRender: true,
          collection: new SectionsCollection
        });
        this.collectionLine.collection.url = 'sections-all';
        this.collectionLine.collection.fetch().then((function(_this) {
          return function() {
            return _this.showFirstModel();
          };
        })(this)).fail((function(_this) {
          return function(e) {
            return App.notifier.show({
              type: 'error',
              text: 'np, sorry'
            });
          };
        })(this));
        this.collectionLine.collection.onSelect = (function(_this) {
          return function(model) {
            return _this.renderEditCollectionView(model);
          };
        })(this);
        return this.collectionLine.collection.on('remove', _.bind(this.showFirstModel, this));
      };

      Edit.prototype.showFirstModel = function() {
        var _ref;
        console.log(this.collectionLine.collection);
        return this.renderEditCollectionView((_ref = this.collectionLine.collection.at(0)) != null ? _ref.set('isSelected', true) : void 0);
      };

      Edit.prototype.renderEditCollectionView = function(model) {
        var _ref;
        if ((_ref = this.editCollectionView) != null) {
          _ref.teardown();
        }
        return this.editCollectionView = new EditCollectionView({
          $el: this.$('#js-edit-collection-view-place'),
          isRender: true,
          model: model || new IconsCollectionModel,
          mode: 'edit'
        });
      };

      return Edit;

    })(PageView);
    return Edit;
  });

}).call(this);
