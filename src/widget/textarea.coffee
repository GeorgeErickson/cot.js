CHANGE_EVENTS = 'textInput keydown keyup select cut paste'

define ->
  class Textarea
    constructor: (@el) ->
      @$el = $ @el
      @attach()

    attach: ->
      @$el.on CHANGE_EVENTS, @create_op

    create_op: (e) ->
      console.log e

  
