(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('models/IconModel', ['models/ProtoModel', 'helpers'], function(ProtoModel, helpers) {
    var IconModel;
    IconModel = (function(_super) {
      __extends(IconModel, _super);

      function IconModel() {
        return IconModel.__super__.constructor.apply(this, arguments);
      }

      IconModel.prototype.defaults = {
        isSelected: false,
        isFiltered: false,
        hover: false,
        active: false,
        focus: false,
        name: '',
        shape: null,
        hash: null,
        isNameValid: false,
        isShapeValid: false,
        isValid: false
      };

      IconModel.prototype.toggleSelected = function() {
        var _base;
        this.toggleAttr('isSelected');
        if ((_base = this.collection).selectedCnt == null) {
          _base.selectedCnt = 0;
        }
        if (this.get('isSelected')) {
          this.collection.selectedCnt++;
        } else {
          this.collection.selectedCnt--;
        }
        App.iconsSelected = helpers.toggleArray(App.iconsSelected, "" + (this.collection.parentModel.get('name')) + ":" + (this.get('hash')));
        return this.calcSelected();
      };

      IconModel.prototype.deselect = function() {
        return this.select(false);
      };

      IconModel.prototype.select = function(val) {
        var iconsSelected;
        if (val == null) {
          val = true;
        }
        this.set('isSelected', val);
        if (val) {
          App.iconsSelected.push("" + (this.collection.parentModel.get('name')) + ":" + (this.get('hash')));
        } else {
          App.iconsSelected = _.without(App.iconsSelected, "" + (this.collection.parentModel.get('name')) + ":" + (this.get('hash')));
        }
        val && (iconsSelected = _.uniq(App.iconsSelected));
        return this.calcSelected();
      };

      IconModel.prototype.calcSelected = function() {
        return App.vent.trigger('icon:select');
      };

      return IconModel;

    })(ProtoModel);
    return IconModel;
  });

}).call(this);
