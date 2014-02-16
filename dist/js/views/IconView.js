(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('views/IconView', ['views/ProtoView', 'models/IconModel', 'underscore', 'jquery', 'helpers'], function(ProtoView, IconModel, _, $, helpers) {
    var IconSelectView;
    IconSelectView = (function(_super) {
      __extends(IconSelectView, _super);

      function IconSelectView() {
        return IconSelectView.__super__.constructor.apply(this, arguments);
      }

      IconSelectView.prototype.model = IconModel;

      IconSelectView.prototype.template = '#icon-view-template';

      IconSelectView.prototype.className = 'icon-with-text-b';

      IconSelectView.prototype.events = {
        'click': 'toggleSelected'
      };

      IconSelectView.prototype.initialize = function(o) {
        this.o = o != null ? o : {};
        this.bindModelEvents();
        IconSelectView.__super__.initialize.apply(this, arguments);
        return this;
      };

      IconSelectView.prototype.bindModelEvents = function() {
        return this.model.on('change', this.render);
      };

      IconSelectView.prototype.render = function() {
        IconSelectView.__super__.render.apply(this, arguments);
        this.$el.toggleClass('is-check', this.model.get('isSelected'));
        this.$el.toggleClass('h-gm', this.model.get('isFiltered'));
        App.vent.on('icon:deselect', _.bind(this.deselect, this));
        return this;
      };

      IconSelectView.prototype.deselect = function() {
        return this.model.deselect();
      };

      IconSelectView.prototype.toggleSelected = function() {
        return this.model.toggleSelected();
      };

      return IconSelectView;

    })(ProtoView);
    return IconSelectView;
  });

}).call(this);
