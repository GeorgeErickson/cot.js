(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['Events'], function(Events) {
    var PeerSync;

    return PeerSync = (function() {
      function PeerSync(widget) {
        var _ref,
          _this = this;

        this.widget = widget;
        this.attach_events = __bind(this.attach_events, this);
        this.uuid = (_ref = widget.uuid) != null ? _ref : Math.uuid(8, 64);
        this.peer = new Peer(this.uuid, {
          host: '18.181.4.144',
          port: 8080,
          debug: false
        });
        this.peer.on('connection', this.attach_events);
        this.peer.on('open', function() {
          var conn, p, _i, _len, _ref1, _results;

          _ref1 = _.without(window.peers, _this.uuid);
          _results = [];
          for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
            p = _ref1[_i];
            conn = _this.peer.connect(p, {
              reliable: true
            });
            _results.push(_this.attach_events(conn));
          }
          return _results;
        });
      }

      PeerSync.prototype.attach_events = function(conn) {
        var _this = this;

        conn.on('open', function() {
          return conn.send({
            type: 'sync',
            data: {
              uuid: _this.uuid,
              version: _this.widget.getVersion()
            }
          });
        });
        PubSub.subscribe(Events.CHANGE, function(en, data) {
          return conn.send({
            type: 'apply',
            data: data
          });
        });
        return conn.on('data', function(resp) {
          var version;

          switch (resp.type) {
            case 'apply':
              return PubSub.publish(Events.APPLY, resp.data);
            case 'sync':
              version = _this.widget.getVersion();
              if (version > resp.data.version) {
                return conn.send({
                  type: 'replace',
                  data: {
                    uuid: _this.uuid,
                    text: _this.widget.getClientData(),
                    version: version
                  }
                });
              }
              break;
            case 'replace':
              return PubSub.publish(Events.REPLACE, resp.data);
          }
        });
      };

      PeerSync.prototype.onchange = function(data) {};

      return PeerSync;

    })();
  });

}).call(this);
