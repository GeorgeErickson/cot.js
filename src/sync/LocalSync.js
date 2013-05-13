(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['Events', 'sync/BaseSync'], function(Events, BaseSync) {
    var LocalSync, _ref;

    return LocalSync = (function(_super) {
      __extends(LocalSync, _super);

      function LocalSync() {
        _ref = LocalSync.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LocalSync.prototype.onchange = function(data) {
        return PubSub.publish(Events.APPLY, data);
      };

      return LocalSync;

    })(BaseSync);
  });

}).call(this);
