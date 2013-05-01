require.config
  paths:
    'spec': '../spec'
define [
  'widget/textarea'
  'spec/init'
], (Textarea) ->
  
  $ ->
    new Textarea("#textarea1")