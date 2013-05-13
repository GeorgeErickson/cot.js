define ['widget/DomBase'], (DomBase) ->
  
  class AceWidget extends DomBase
    constructor:(options)->
      @editor = ace.edit('widget')
      @session = @editor.getSession()
      @doc = @session.getDocument()
      @suppress = false
      super options
      

    attachDomEvents: ->
      # input event is only availible in modern browsers
      # TODO - Make sure that cut copy paste work as expected
      @doc.on 'change', (e) =>
        unless @suppress
          @change()


    onreplace: (data) ->
      @suppress = true
      @setShadowData data.text
      @editor.setValue data.text
      @shadows.version = data.version
      @suppress = false

    onapply: (data) ->
      @suppress = true
  
      unless @getVersion() <= data.version
        console.error "Can't apply a delta on a mismatched shadow version."

      shadow_data = @getShadowData()

      patches = @dmp.patch_make shadow_data, data.diffs

      # update local shadow to equal peer shadow
      peer_shadow = @dmp.patch_apply patches, shadow_data
      @setShadowData peer_shadow[0]

      # patch client
      @setClientData patches
      @suppress = false

    setClientData: (patches) ->
      oldClientData = @getClientData()
      result = @dmp.patch_apply patches, oldClientData
      #TODO - cursor preservation
      cursor = @editor.getCursorPosition()
      @doc.getLine cursor.row
      if oldClientData != result[0]
        @editor.setValue result[0], 1
        @editor.moveCursorToPosition cursor
      

    getClientData: ->
      @editor.getValue()

  
