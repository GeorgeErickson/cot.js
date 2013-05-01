require.config
  paths:
    'spec': '../spec'
define [
  'widget/textarea'
  'sync/webrtc'
  #'spec/init'
], (Widget, Sync) ->
  
  $ ->
    new Widget("#textarea1")