(function() {
  define('helpers', ['md5'], function(md5) {
    var Helpers;
    Helpers = (function() {
      function Helpers() {}

      Helpers.prototype.isMobile = function() {
        var check;
        check = false;
        (function(a) {
          if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) {
            return check = true;
          }
        })(navigator.userAgent || navigator.vendor || window.opera);
        return check;
      };

      Helpers.prototype.prefix = function() {
        var dom, pre, styles;
        styles = window.getComputedStyle(document.documentElement, "");
        pre = (Array.prototype.slice.call(styles).join("").match(/-(moz|webkit|ms)-/) || (styles.OLink === "" && ["", "o"]))[1];
        dom = "WebKit|Moz|MS|O".match(new RegExp("(" + pre + ")", "i"))[1];
        return "-" + pre + "-";
      };

      Helpers.prototype.getRandom = function(min, max) {
        return Math.floor((Math.random() * ((max + 1) - min)) + min);
      };

      Helpers.prototype.showLoaderLine = function(className) {
        if (className == null) {
          className = '';
        }
        App.$loadingLine.show().addClass(className);
        return this;
      };

      Helpers.prototype.hideLoaderLine = function(className) {
        if (className == null) {
          className = '';
        }
        App.$loadingLine.fadeOut(200, function() {
          return App.$loadingLine.css({
            'width': '0'
          }).removeClass(className);
        });
        return this;
      };

      Helpers.prototype.setLoaderLineProgress = function(n) {
        App.$loadingLine.css({
          'width': "" + n + "%"
        });
        return this;
      };

      Helpers.prototype.listenLinks = function() {
        return $(document.body).on('click', 'a', function(e) {
          var $it;
          $it = $(this);
          if ($it.attr('target') === '_blank' || $it.attr('href').match(/mailto:/g) || $it.hasClass('js-no-follow')) {
            return;
          }
          e.preventDefault();
          return App.router.navigate($it.attr('href'), {
            trigger: true
          });
        });
      };

      Helpers.prototype.normalizeBoolean = function(val) {
        return (val === 'false') !== (Boolean(val));
      };

      Helpers.prototype.unescape = function(str) {
        return str != null ? str.replace(/\&lt;/g, '<').replace(/\&gt;/g, '>').replace(/\&quot;/g, '"') : void 0;
      };

      Helpers.prototype.generateHash = function() {
        return md5((new Date) + (new Date).getMilliseconds() + Math.random(9999999999999) + Math.random(9999999999999) + Math.random(9999999999999));
      };

      Helpers.prototype.refreshSvg = function() {
        return App.$svgWrap.html(App.$svgWrap.html());
      };

      Helpers.prototype.getFilterIcon = function(direction) {
        if (this.currIconIndex == null) {
          this.currIconIndex = 0;
        }
        if (direction === '<') {
          this.currIconIndex--;
          this.currIconIndex < 0 && (this.currIconIndex = App.iconsSelected.length - 1);
        } else {
          this.currIconIndex++;
          this.currIconIndex >= App.iconsSelected.length && (this.currIconIndex = 0);
          this.currIconIndex++;
          this.currIconIndex >= App.iconsSelected.length && (this.currIconIndex = 0);
        }
        if (App.iconsSelected[this.currIconIndex]) {
          return App.iconsSelected[this.currIconIndex].split(':')[1];
        } else {
          return this.getStandartIcon(direction);
        }
      };

      Helpers.prototype.getStandartIcon = function(direction) {
        var iconsSource, _ref;
        iconsSource = App.sectionsCollectionView.collection.at(0).get('icons');
        if (this.currStandartIconIndex == null) {
          this.currStandartIconIndex = 0;
        }
        if (direction === '<') {
          this.currStandartIconIndex--;
          this.currStandartIconIndex < 0 && (this.currStandartIconIndex = iconsSource.length - 1);
        } else {
          this.currStandartIconIndex++;
          this.currStandartIconIndex >= iconsSource.length && (this.currStandartIconIndex = 0);
        }
        return ((_ref = iconsSource[this.currStandartIconIndex]) != null ? _ref.hash : void 0) || 'tick-icon';
      };

      Helpers.prototype.upsetSvgShape = function(o) {
        var $shape, i, isLoaded;
        isLoaded = false;
        if (o.isReset) {
          App.$svgWrap.find("#" + o.hash).remove();
        }
        if (o.isCheck) {
          i = 0;
          while (i < App.loadedHashes.length) {
            if (String(App.loadedHashes[i]) === String(o.hash)) {
              isLoaded = true;
              i = App.loadedHashes.length;
            }
            i++;
          }
        }
        if (!isLoaded) {
          $shape = $('<g>').html(o.shape).attr('id', o.hash);
          $shape.find('*').each(function(i, child) {
            var $child;
            $child = $(child);
            if (!o.isMulticolor) {
              if ($child.attr('fill') !== 'none') {
                return $child.removeAttr('fill');
              }
            }
          });
          o.$shapes.append($shape);
          return App.loadedHashes.push(o.hash);
        }
      };

      Helpers.prototype.addToSvg = function($shapes) {
        var data;
        data = $shapes instanceof $ ? $shapes.html() : $shapes;
        App.$svgWrap.find('#svg-source').append(data);
        return this.refreshSvg();
      };

      Helpers.prototype.placeInSvg = function(data) {
        var hook, svg;
        hook = 'js-icons-data-place';
        App.$svgWrap.find('#js-icons-data-place').remove();
        svg = App.$svgWrap.html();
        svg = svg.replace(/<!-- icons data marker -->/gi, "<!-- icons data marker --><defs id='" + hook + "'>" + data + "</defs>");
        App.$svgWrap.html(svg);
        return data;
      };

      Helpers.prototype.toggleArray = function(array, item, isSingle) {
        var indexOfItem, newArray;
        if (array == null) {
          return void 0;
        }
        newArray = array.slice(0);
        indexOfItem = _.indexOf(newArray, item);
        if (indexOfItem === -1) {
          newArray.push(item);
        } else {
          if (isSingle) {
            newArray.splice(indexOfItem, 1);
          } else {
            newArray = _.without(newArray, item);
          }
        }
        return newArray;
      };

      return Helpers;

    })();
    return new Helpers;
  });

}).call(this);
