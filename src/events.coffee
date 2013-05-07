ROOT = 'ds'

define ->
  Events = 
    ROOT: ROOT

    # The the text or data of a widget has changed due to user input.
    CHANGE: "#{ ROOT }.change"

    # Incoming change should be applied.
    APPLY: "#{ ROOT }.apply"

  class Events.Mixin
    constructor: ->
      @delegateEvents()
    
    undelegateEvents: ->
      @_listeners ?= []
      for listener in @_listeners
        do (listener) ->
          PubSub.unsubscribe listener
      
    delegateEvents: ->
      @undelegateEvents()
      for own en, method of _.result @, 'events'
        event_name = Events[en]
        unless event_name
          console.error "#{ en } is not a valid event name"

        unless _.isFunction method
          method = @[method]

        if method
          bound_method = _.bind method, @
          @_listeners.push PubSub.subscribe event_name, (en, data) =>
            # Ignore my own events
            if @uuid != data.uuid
              bound_method(data)

    destroy: ->
      @undelegateEvents()

  return Events
  
  
