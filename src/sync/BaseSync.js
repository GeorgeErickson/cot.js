(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['Events'], function(Events) {
    var BaseSync;

    return BaseSync = (function(_super) {
      __extends(BaseSync, _super);

      BaseSync.prototype.defaults = {
        uuid: Math.uuid()
      };

      BaseSync.prototype.events = {
        'CHANGE': 'onchange'
      };

      function BaseSync(options) {
        this.options = options;
        _.extend(this, this.defaults, options);
        this.delegateEvents();
      }

      BaseSync.prototype.onchange = function(data) {
        return console.error('Subclasses should create');
      };

      return BaseSync;

    })(Events.Mixin);
  });

}).call(this);
