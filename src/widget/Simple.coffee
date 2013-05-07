define ['core'], (DSCore) ->
  
  class Simple extends DSCore
    #Just uses an internal text attribute
    constructor: (options) ->
      super
      @text = options?.text ? ''

    setClientData: (text) ->
      #used to change value for testing
      @setShadowData @text
      @text = text

    getClientData: (text) ->
      @text


  
