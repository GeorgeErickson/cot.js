(function() {
  require.config({
    baseUrl: 'src'
  });

  define(['Events', 'widget/ContentEditable', 'sync/WebrtcSync'], function(Events, Widget, Sync) {
    var widget;

    widget = new Widget({
      el: '#widget',
      uuid: Math.uuid(8, 64)
    });
    new Sync(widget);
    return PubSub.subscribe(Events.ROOT, function(en, data) {
      return console.log(en, data);
    });
  });

}).call(this);
