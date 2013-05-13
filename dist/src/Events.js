(function() {
  var ROOT, USER,
    __hasProp = {}.hasOwnProperty;

  ROOT = 'ds';

  USER = 'ds.user';

  define(function() {
    var Events;

    Events = {
      ROOT: ROOT,
      CHANGE: "" + ROOT + ".change",
      APPLY: "" + ROOT + ".apply",
      REPLACE: "" + ROOT + ".replace",
      COLLAB_ADD: "" + USER + ".collab.add",
      COLLAB_REMOVE: "" + USER + ".collab.remove"
    };
    Events.Mixin = (function() {
      function Mixin() {
        this.delegateEvents();
      }

      Mixin.prototype.undelegateEvents = function() {
        var listener, _i, _len, _ref, _ref1, _results;

        if ((_ref = this._listeners) == null) {
          this._listeners = [];
        }
        _ref1 = this._listeners;
        _results = [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          listener = _ref1[_i];
          _results.push((function(listener) {
            return PubSub.unsubscribe(listener);
          })(listener));
        }
        return _results;
      };

      Mixin.prototype.delegateEvents = function() {
        var en, method, _ref, _results,
          _this = this;

        this.undelegateEvents();
        _ref = _.result(this, 'events');
        _results = [];
        for (en in _ref) {
          if (!__hasProp.call(_ref, en)) continue;
          method = _ref[en];
          _results.push((function(en, method) {
            var bound_method, event_name;

            event_name = Events[en];
            if (!event_name) {
              console.error("" + en + " is not a valid event name");
            }
            if (!_.isFunction(method)) {
              method = _this[method];
            }
            if (method) {
              bound_method = _.bind(method, _this);
              return _this._listeners.push(PubSub.subscribe(event_name, function(en, data) {
                if (_this.uuid !== data.uuid) {
                  return bound_method(data);
                }
              }));
            }
          })(en, method));
        }
        return _results;
      };

      Mixin.prototype.destroy = function() {
        return this.undelegateEvents();
      };

      return Mixin;

    })();
    return Events;
  });

}).call(this);
