require.config
  paths:
    'spec': '../spec'
define [
  'widget/ContentEditable'
  'events'
  #Tests
  'spec/init'
], (ContentEditable, events) ->
  
  window.w1 = new ContentEditable
    el: "#widget-1"

  window.w2 = new ContentEditable
    el: "#widget-2"


  PubSub.subscribe events.ROOT, (en, data)->
    console.log en, data
  
