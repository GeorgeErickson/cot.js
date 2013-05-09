require.config
  baseUrl: 'src'
  paths:
    'spec': '../spec'

define [
  'Events'
  'widget/ContentEditable'
  'sync/WebrtcSync'
], (Events, Widget, Sync, User, CollabWidget) ->
  sync = new Sync
  console.log sync.uuid
  
  DS =
    user: user
    widget: new Widget
      el: '#widget'
      uuid: cid
    
    sync: new Sync
      uuid: user.uuid

  User.insert_uuid '#uuid-display'
  new CollabWidget
    el: '#collab-widget'
  window.DS = DS





  PubSub.subscribe Events.ROOT, (en, data)->
    console.log en, data
  
