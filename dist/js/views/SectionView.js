(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/SectionView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore'], function(ProtoView, SectionModel, IconsCollectionView, IconsCollection, _) {
    var SectionView;
    SectionView = (function(_super) {
      __extends(SectionView, _super);

      function SectionView() {
        return SectionView.__super__.constructor.apply(this, arguments);
      }

      SectionView.prototype.model = SectionModel;

      SectionView.prototype.template = '#section-view-template';

      SectionView.prototype.className = 'section-b cf h-gm';

      SectionView.prototype.events = {
        'click #js-hide': 'toggleHide',
        'click #js-select-all': 'selectAll',
        'click #js-deselect-all': 'deSelectAll',
        'click #js-show-more': 'toggleExpand'
      };

      SectionView.prototype.initialize = function() {
        this.bindModelEvents();
        SectionView.__super__.initialize.apply(this, arguments);
        this.listenToOverflow();
        return this;
      };

      SectionView.prototype.bindModelEvents = function() {
        this.model.on('change:isFiltered', _.bind(this.toggleClasses, this));
        this.model.on('change:isClosed', _.bind(this.toggleClasses, this));
        return this.model.on('change:isExpanded', _.bind(this.toggleClasses, this));
      };

      SectionView.prototype.render = function() {
        SectionView.__super__.render.apply(this, arguments);
        this.renderIcons();
        this.$content = this.$('#js-icons-place');
        this.toggleClasses(false);
        _.defer((function(_this) {
          return function() {
            return _this.toggleExpandedBtn();
          };
        })(this));
        this.animateIn();
        return this;
      };

      SectionView.prototype.listenToOverflow = function() {
        return $(window).on('resize', _.bind(this.toggleExpandedBtn, this));
      };

      SectionView.prototype.isExpandBtnNeeded = function() {
        return this.$el.hasClass('is-expanded') || this.$content.outerHeight() < this.$content[0].scrollHeight;
      };

      SectionView.prototype.toggleExpand = function() {
        return this.model.toggleAttr('isExpanded');
      };

      SectionView.prototype.toggleExpandedBtn = function() {
        return this.$el.toggleClass('is-no-expanded-btn', !this.isExpandBtnNeeded());
      };

      SectionView.prototype.onFilter = function(state) {
        this.toggleExpandedBtn();
        return this.model.set('isFiltered', state);
      };

      SectionView.prototype.renderIcons = function() {
        this.iconsCollectionView = new IconsCollectionView({
          $el: this.$('#js-icons-place'),
          isRender: true,
          collection: new IconsCollection(this.model.get('icons'))
        });
        this.iconsCollectionView.collection.onFilter = _.bind(this.onFilter, this);
        this.iconsCollectionView.collection.parentModel = this.model;
        this.model.iconsCollection = this.iconsCollectionView.collection;
        return this.model.iconsCollectionView = this.iconsCollectionView;
      };

      SectionView.prototype.toggleClasses = function(isToggleBtn) {
        if (isToggleBtn == null) {
          isToggleBtn = true;
        }
        this.$el.toggleClass('is-closed', !!this.model.get('isClosed'));
        this.$el.toggleClass('h-gm', !!this.model.get('isFiltered'));
        this.$el.toggleClass('is-expanded', !!this.model.get('isExpanded'));
        isToggleBtn && this.toggleExpandedBtn();
        return this.$('#js-show-more').text(!!this.model.get('isExpanded') ? 'show less' : 'show more');
      };

      SectionView.prototype.selectAll = function() {
        this.iconsCollectionView.collection.selectAll();
        return App.vent.trigger('icon:select');
      };

      SectionView.prototype.deSelectAll = function() {
        this.iconsCollectionView.collection.deSelectAll();
        return App.vent.trigger('icon:select');
      };

      SectionView.prototype.toggleHide = function() {
        this.model.toggleAttr('isClosed');
        return this.$content.slideToggle();
      };

      return SectionView;

    })(ProtoView);
    return SectionView;
  });

}).call(this);
