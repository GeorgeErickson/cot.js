define ['Events', 'demo/user'], (Events, User) ->
  templates =
    add: """
      <div class="input-append">
        <input name='uuid' placeholder="Collaborator's UUID" type="text">
        <button type="submit" class="btn btn-success"><i class="icon-plus"></i></button>
      </div>"""
    select: '<select multiple="multiple"></select>'



  class CollaboratorWidget extends Backbone.View
    events:
      'click button': 'add_collab'

    initialize: ->
      @select = $ templates.select

      
      add_container = $ templates.add
      @$el.append add_container
      @$el.append @select
      @add_input = @$el.find 'input[name=uuid]'
      @select.bsmSelect
        removeLabel: '<i class="icon-remove"></i>'


      for collab in User.get_or_create().collabs ? []
        @add collab
      @select.change (e, data) =>
        #determine if add or remove
        user = User.get_or_create()
        oc = user.collabs ? []
        nc = @select.val() ? []

        User.update
          collabs: _.uniq nc

        #Remove
        if oc.length > nc.length
          removed = _.difference oc, nc
          PubSub.publish Events.COLLAB_REMOVE,
            uuid: removed[0]
        #Add
        else if oc.length < nc.length
          added = _.difference nc, oc
          PubSub.publish Events.COLLAB_ADD,
            uuid: added[0]




    add: (u) ->
      @select.append($("<option>", { text: u, selected: "selected"})).change()
    
    add_collab: ->
      @add @add_input.val()
      @add_input.val ""