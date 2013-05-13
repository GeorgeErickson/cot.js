require.config
  baseUrl: 'src'

define [
  'Events'
  'widget/Ace'
  'sync/WebrtcSync'
], (Events, Widget, Sync) ->
  widget = new Widget
    el: '#widget'
    uuid: Math.uuid(8, 64)

  new Sync widget








  PubSub.subscribe Events.ROOT, (en, data)->
    console.log en, data
  
