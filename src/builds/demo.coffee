require.config
  baseUrl: 'src'

define [
  'Events'
  'widget/ContentEditable'
  'sync/WebrtcSync'
], (Events, Widget, Sync) ->
  uuid = Math.uuid(8, 64)
  new Sync uuid
  new Widget
    el: '#widget'
    uuid: uuid








  PubSub.subscribe Events.ROOT, (en, data)->
    console.log en, data
  
