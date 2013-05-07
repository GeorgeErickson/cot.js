define ->
  user = 
    get_or_create: ->
      user = store.get 'user'
      unless user
        user = 
          uuid: uuid.v4().replace /-/g, '' #dashes make it hard to copy
      @save user

    insert_uuid: (el) ->
      $el = $ el
      $el.html @get_or_create().uuid

    save: (user) ->
      store.set 'user', user

    update: (data) ->
      user = @get_or_create()
      _.extend user, data
      @save user
              