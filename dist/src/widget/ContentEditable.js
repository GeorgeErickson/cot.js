(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['widget/DomBase'], function(DomBase) {
    var ContentEditable, _ref;

    return ContentEditable = (function(_super) {
      __extends(ContentEditable, _super);

      function ContentEditable() {
        _ref = ContentEditable.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentEditable.prototype.attachDomEvents = function() {
        var _this = this;

        return this.$el.on('input', function(e) {
          return _this.change();
        });
      };

      ContentEditable.prototype.onreplace = function(data) {
        this.setShadowData(data.text);
        this.$el.html(data.text);
        console.log(data);
        return this.shadows.version = data.version;
      };

      ContentEditable.prototype.onapply = function(data) {
        var patches, peer_shadow, shadow_data;

        if (!(this.getVersion() <= data.version)) {
          console.error("Can't apply a delta on a mismatched shadow version.");
        }
        shadow_data = this.getShadowData();
        patches = this.dmp.patch_make(shadow_data, data.diffs);
        peer_shadow = this.dmp.patch_apply(patches, shadow_data);
        this.setShadowData(peer_shadow[0]);
        return this.setClientData(patches);
      };

      ContentEditable.prototype.setClientData = function(patches) {
        var oldClientData, result;

        oldClientData = this.getClientData();
        result = this.dmp.patch_apply(patches, oldClientData);
        if (oldClientData !== result[0]) {
          return this.$el.html(result[0]);
        }
      };

      ContentEditable.prototype.getClientData = function() {
        return this.$el.html();
      };

      return ContentEditable;

    })(DomBase);
  });

}).call(this);
