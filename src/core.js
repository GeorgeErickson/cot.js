(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['Events'], function(Events) {
    var DSCore, ShadowStore;

    ShadowStore = (function() {
      function ShadowStore(initial) {
        this.data = initial;
        this.version = 0;
      }

      /*
      Return shadow n, or last shadow if n is undefined.
      */


      ShadowStore.prototype.get = function(n) {
        return this.data;
      };

      ShadowStore.prototype.add = function(text) {
        this.data = text;
        return this.version += 1;
      };

      return ShadowStore;

    })();
    return DSCore = (function(_super) {
      __extends(DSCore, _super);

      DSCore.prototype.defaults = {
        uuid: Math.uuid(),
        dmp: new diff_match_patch()
      };

      DSCore.prototype.dmp_settings = {
        Diff_Timeout: 0.5,
        Match_Distance: 1000,
        Match_Threshold: 0.6
      };

      function DSCore(options) {
        this.options = options;
        _.extend(this, this.defaults, options);
        _.extend(this.dmp, this.dmp_settings);
        this.shadows = new ShadowStore("");
        DSCore.__super__.constructor.apply(this, arguments);
      }

      DSCore.prototype.events = {
        'APPLY': 'onapply',
        'REPLACE': 'onreplace'
      };

      DSCore.prototype.createDiff = function() {
        var diffs;

        diffs = this.dmp.diff_main(this.getShadowData(), this.getClientData(), true);
        if (diffs.length > 2) {
          this.dmp.diff_cleanupSemantic(diffs);
          this.dmp.diff_cleanupEfficiency(diffs);
        }
        return diffs;
      };

      DSCore.prototype.getClientData = function() {
        throw Error('Must be implmented by subclass');
      };

      DSCore.prototype.setClientData = function() {
        throw Error('Must be implmented by subclass');
      };

      DSCore.prototype.getShadowData = function() {
        return this.shadows.get();
      };

      DSCore.prototype.setShadowData = function(data) {
        return this.shadows.add(data);
      };

      DSCore.prototype.getVersion = function() {
        return this.shadows.version;
      };

      DSCore.prototype.onapply = function() {
        throw Error('Must be implemented by subclass');
      };

      DSCore.prototype.change = function() {
        var changed, data, diffs;

        diffs = this.createDiff();
        data = this.getClientData();
        changed = diffs.length !== 1 || diffs[0][0] !== DIFF_EQUAL;
        if (diffs && changed) {
          PubSub.publish(Events.CHANGE, {
            uuid: this.uuid,
            diffs: diffs,
            version: this.getVersion()
          });
          return this.setShadowData(data);
        }
      };

      return DSCore;

    })(Events.Mixin);
  });

}).call(this);
