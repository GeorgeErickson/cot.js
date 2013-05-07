define ['core'], (DSCore) ->
  
  class DomBase extends DSCore
    attachDomEvents: ->
      #implemented by subclasses
    
    constructor: (options) ->
      super
      unless options?.el
        throw Error 'options.el is required'
      @$el = $ options.el
      unless @$el.length
        throw Error 'options.el must exist'

      @attachDomEvents()

  
