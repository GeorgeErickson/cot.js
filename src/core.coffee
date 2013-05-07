define ['events'], (events) ->
  class ShadowStore
    constructor: ->
      @versions = [""]

    ###
    Return shadow n, or last shadow if n is undefined.
    ###
    get: (n) ->
      if _.isUndefined n
        return _.last @versions
      @versions[n]

    add: (text) ->
      @versions.push text

    version: ->
      @versions.length

  class DSCore
    constructor: (options) ->
      @options = options ? {}
      @id = uuid()
      @dmp = new diff_match_patch()
      @dmp.Diff_Timeout = 0.5
      @shadows = new ShadowStore

    createDiff: ->
      diffs = @dmp.diff_main @getShadowData(), @getClientData(), true

      #compress diffs
      if diffs.length > 2
        @dmp.diff_cleanupSemantic diffs
        @dmp.diff_cleanupEfficiency diffs

      diffs

    getClientData: ->
      throw Error 'Must be implmented by subclass'

    getShadowData: ->
      @shadows.get()

    setShadowData: (data) ->
      @shadows.add data


    change: ->
      diffs = @createDiff()
      text = @getClientData()
      changed = diffs.length != 1 or diffs[0][0] != DIFF_EQUAL

      if changed
        PubSub.publish events.CHANGE,
          id: @id
          text: text #TODO - Make short hash
          diffs: @dmp.diff_toDelta(diffs)
          version: @shadows.length

        @shadows.addShadow text