(function() {
  require.config({
    baseUrl: 'src',
    paths: {
      'spec': '../spec'
    }
  });

  define(['Events', 'widget/ContentEditable', 'sync/LocalSync', 'spec/init'], function(Events, ContentEditable, LocalSync) {
    var el, _fn, _i, _len, _ref;

    _ref = ['#widget-1', '#widget-2'];
    _fn = function(el) {
      var u;

      u = Math.uuid();
      new ContentEditable({
        el: el,
        uuid: u
      });
      return new LocalSync({
        uuid: u
      });
    };
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      el = _ref[_i];
      _fn(el);
    }
    return PubSub.subscribe(Events.ROOT, function(en, data) {
      return console.log(en, data);
    });
  });

}).call(this);
