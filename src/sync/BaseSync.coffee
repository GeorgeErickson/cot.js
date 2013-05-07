define ['Events'], (Events) ->
  class BaseSync extends Events.Mixin
    defaults:
      uuid: uuid.v4()

    events:
      'CHANGE': 'onchange'

    constructor: (@options) ->
      _.extend @, @defaults, options
      @delegateEvents()

    
    onchange: (data) ->
      console.error 'Subclasses should create'



