(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['core'], function(DSCore) {
    var DomBase;

    return DomBase = (function(_super) {
      __extends(DomBase, _super);

      DomBase.prototype.attachDomEvents = function() {};

      function DomBase(options) {
        DomBase.__super__.constructor.apply(this, arguments);
        if (!(options != null ? options.el : void 0)) {
          throw Error('options.el is required');
        }
        this.$el = $(options.el);
        if (!this.$el.length) {
          throw Error('options.el must exist');
        }
        this.attachDomEvents();
      }

      return DomBase;

    })(DSCore);
  });

}).call(this);
