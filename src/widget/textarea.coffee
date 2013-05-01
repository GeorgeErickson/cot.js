CHANGE_EVENTS = 'textInput keyup keydown delete select cut paste'

define ['ops/insert'], (Insert) ->
  class Textarea
    get_current_state: ->
      @$el.val()

    constructor: (@el) ->
      @dmp = new diff_match_patch()
      @$el = $ @el
      @previous_state = @get_current_state()
      @attach()

    attach: ->
      @$el.on CHANGE_EVENTS, @create_op

      PubSub.subscribe 'apply', @apply_op

    apply_op: (en, patch_text) =>
      patch = @dmp.patch_fromText patch_text
      next_text = @dmp.patch_apply patch, @get_current_state()
      @$el.val next_text[0]
      
    create_op: (e) =>
      patch_array = @dmp.patch_make @previous_state, @get_current_state()
      @previous_state = @get_current_state()
      # @dmp.diff_cleanupEfficiency diff_array
      
      new Insert(@dmp.patch_toText(patch_array))
  
