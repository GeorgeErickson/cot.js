define ['Events', 'sync/BaseSync'], (Events, BaseSync) ->
  
  class LocalSync extends BaseSync
    onchange: (data) ->
      PubSub.publish Events.APPLY, data