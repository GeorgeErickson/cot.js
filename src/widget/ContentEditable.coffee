define ['widget/DomBase'], (DomBase) ->
  
  class ContentEditable extends DomBase
    attachDomEvents: ->
      # input event is only availible in modern browsers
      # TODO - Make sure that cut copy paste work as expected
      @$el.on 'input', (e) =>
        @change()

    #override original
    getClientText: ->
      @$el.html()

  
