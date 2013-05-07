define ['widget/DomBase'], (DomBase) ->
  
  class ContentEditable extends DomBase
    attachDomEvents: ->
      # input event is only availible in modern browsers
      # TODO - Make sure that cut copy paste work as expected
      @$el.on 'input', (e) =>
        @change()

    onapply: (data) ->
      unless @getVersion() == data.version
        console.error "Can't apply a delta on a mismatched shadow version."
      shadow_data = @getShadowData()

      patches = @dmp.patch_make shadow_data, data.diffs

      # update local shadow to equal peer shadow
      peer_shadow = @dmp.patch_apply patches, shadow_data
      @setShadowData peer_shadow[0]

      # patch client
      @setClientData patches

    setClientData: (patches) ->
      oldClientData = @getClientData()
      result = @dmp.patch_apply patches, oldClientData
      #TODO - cursor preservation
      if oldClientData != result[0]
        @$el.html result[0]
      

    getClientData: ->
      @$el.html()

  
