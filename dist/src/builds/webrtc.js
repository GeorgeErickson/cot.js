(function() {
  require.config({
    baseUrl: 'src',
    paths: {
      'spec': '../spec'
    }
  });

  define(['Events', 'widget/ContentEditable', 'sync/WebrtcSync'], function(Events, Widget, Sync, User, CollabWidget) {
    var DS, sync;

    sync = new Sync;
    console.log(sync.uuid);
    DS = {
      user: user,
      widget: new Widget({
        el: '#widget',
        uuid: cid
      }),
      sync: new Sync({
        uuid: user.uuid
      })
    };
    User.insert_uuid('#uuid-display');
    new CollabWidget({
      el: '#collab-widget'
    });
    window.DS = DS;
    return PubSub.subscribe(Events.ROOT, function(en, data) {
      return console.log(en, data);
    });
  });

}).call(this);
