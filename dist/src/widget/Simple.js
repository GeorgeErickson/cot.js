(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['core'], function(DSCore) {
    var Simple;

    return Simple = (function(_super) {
      __extends(Simple, _super);

      function Simple(options) {
        var _ref;

        Simple.__super__.constructor.apply(this, arguments);
        this.text = (_ref = options != null ? options.text : void 0) != null ? _ref : '';
      }

      Simple.prototype.setClientData = function(text) {
        this.setShadowData(this.text);
        return this.text = text;
      };

      Simple.prototype.getClientData = function(text) {
        return this.text;
      };

      return Simple;

    })(DSCore);
  });

}).call(this);
