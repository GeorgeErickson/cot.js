define ['Events'], (Events) ->
  class ShadowStore
    constructor: (initial) ->
      @data = initial
      @version = 0

    ###
    Return shadow n, or last shadow if n is undefined.
    ###
    get: (n) ->
      @data

    add: (text) ->
      @data = text
      @version += 1


  class DSCore extends Events.Mixin
    defaults:
      uuid: Math.uuid()
      dmp: new diff_match_patch()
    
    dmp_settings:
      Diff_Timeout: 0.5
      Match_Distance: 1000
      Match_Threshold: 0.6
    
    constructor: (@options) ->
      _.extend @, @defaults, options
      _.extend @dmp, @dmp_settings
      @shadows = new ShadowStore ""
      super

    events:
      'APPLY': 'onapply',
      'REPLACE': 'onreplace'

    createDiff: ->
      diffs = @dmp.diff_main @getShadowData(), @getClientData(), true

      #compress diffs
      if diffs.length > 2
        @dmp.diff_cleanupSemantic diffs
        @dmp.diff_cleanupEfficiency diffs

      diffs

    getClientData: ->
      throw Error 'Must be implmented by subclass'

    setClientData: ->
      throw Error 'Must be implmented by subclass'


    getShadowData: ->
      @shadows.get()

    setShadowData: (data) ->
      @shadows.add data

    getVersion: ->
      @shadows.version

    onapply: ->
      throw Error 'Must be implemented by subclass'

    change: ->
      diffs = @createDiff()
      data = @getClientData()
      changed = diffs.length != 1 or diffs[0][0] != DIFF_EQUAL

      if diffs and changed
        PubSub.publish Events.CHANGE,
          uuid: @uuid
          diffs: diffs
          version: @getVersion()

        @setShadowData data