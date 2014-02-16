(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/SectionLineView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore', 'helpers'], function(ProtoView, SectionModel, IconsCollectionView, IconsCollection, _, helpers) {
    var SectionView;
    SectionView = (function(_super) {
      __extends(SectionView, _super);

      function SectionView() {
        return SectionView.__super__.constructor.apply(this, arguments);
      }

      SectionView.prototype.model = SectionModel;

      SectionView.prototype.template = '#section-line-view-template';

      SectionView.prototype.className = 'icons-set-b';

      SectionView.prototype.events = {
        'click': 'selectMe'
      };

      SectionView.prototype.initialize = function() {
        this.makePreviewSvg();
        this.model.on('change:isSelected', _.bind(this.render, this));
        SectionView.__super__.initialize.apply(this, arguments);
        return this;
      };

      SectionView.prototype.selectMe = function() {
        var _base;
        if (typeof (_base = this.model.collection).onSelect === "function") {
          _base.onSelect(this.model);
        }
        return this.model.set('isSelected', true);
      };

      SectionView.prototype.makePreviewSvg = function() {
        var $shapes, i, icons, _ref, _ref1;
        i = 0;
        icons = this.model.get('icons');
        $shapes = $('<div>');
        while (i < 6) {
          helpers.upsetSvgShape({
            hash: (_ref = icons[i]) != null ? _ref.hash : void 0,
            shape: (_ref1 = icons[i]) != null ? _ref1.shape : void 0,
            $shapes: $shapes,
            isMulticolor: this.model.get('isMulticolor')
          });
          i++;
        }
        return helpers.addToSvg($shapes);
      };

      SectionView.prototype.render = function() {
        SectionView.__super__.render.apply(this, arguments);
        this.$el.toggleClass('is-check', !!this.model.get('isSelected'));
        this.$el.toggleClass('is-not-moderated', !this.model.get('moderated'));
        this.checkIfSelected();
        return this;
      };

      SectionView.prototype.checkIfSelected = function() {
        var _ref;
        if ((_ref = this.model.collection.currentSelectedModel) != null) {
          _ref.set('isSelected', false);
        }
        if (this.model.get('isSelected')) {
          return this.model.collection.currentSelectedModel = this.model;
        }
      };

      return SectionView;

    })(ProtoView);
    return SectionView;
  });

}).call(this);
