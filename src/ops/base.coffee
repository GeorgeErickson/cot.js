define ->
  class Base
    name: 'base'
    
    constructor: (@data) ->
      PubSub.publish "op.#{ @name }", @get_data()

    get_data: ->
      @data
    
  