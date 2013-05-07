require.config
  paths:
    'spec': '../spec'
define [
  'Events'
  'widget/ContentEditable'
  'sync/LocalSync'
  #Tests
  'spec/init'
], (Events, ContentEditable, LocalSync) ->
  

  for el in ['#widget-1', '#widget-2']
    do (el) ->
      u = uuid.v4()
      
      new ContentEditable
        el: el
        uuid: u

      new LocalSync
        uuid: u



  PubSub.subscribe Events.ROOT, (en, data)->
    console.log en, data
  
