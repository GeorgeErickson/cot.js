require.config
  baseUrl: 'src'
  paths:
    'spec': '../spec'

define [
  'Events'
  'widget/ContentEditable'
  'sync/WebrtcSync'
  'demo/user'
  'demo/collaborators'
], (Events, Widget, Sync, User, CollabWidget) ->
  user = User.get_or_create()
  
  DS =
    user: user
    widget: new Widget
      el: '#widget'
      uuid: user.uuid
    sync: new Sync
      uuid: user.uuid

  User.insert_uuid '#uuid-display'
  new CollabWidget
    el: '#collab-widget'
  window.DS = DS





  PubSub.subscribe Events.ROOT, (en, data)->
    console.log en, data
  
