define ['Events'], (Events) ->
  class PeerSync 
    constructor: (uuid) ->
      @uuid = uuid ? Math.uuid(8, 64)
      @peer = new Peer @uuid,
        host: 'p2pserver-george.dotcloud.com'
        port: 80
        debug: true
      @peer.on 'connection', @attach_events
      @peer.on 'open', =>

        #connect to all availible peers
        for p in _.without window.peers, @uuid
          console.log p
          @attach_events @peer.connect p,
            reliable: true

      PubSub.subscribe Events.COLLAB_ADD, (data) =>
        @attach_events @peer.connect data.uuid,
          reliable: true
          

    attach_events: (conn) ->
      # Send Data when changes occur
      PubSub.subscribe Events.CHANGE, (en, data) ->
        conn.send
          APPLY: data

      conn.on 'data', (data) ->
        if data.APPLY
          PubSub.publish Events.APPLY, data.APPLY
        
    
    
    onchange: (data) ->
      #PubSub.publish Events.APPLY, data

  # peer.on 'open', (id) ->
  #   console.log id

  # peer.on 'connection', (conn) ->
  #   conn.on 'data', (data) ->
  #     PubSub.publish 'apply', data

  # window.add_peer = (id) ->
  #   connection = peer.connect id

  #   PubSub.subscribe 'op', (en, data) ->
  #     connection.send data
  
  # PubSub.subscribe Events.COLLAB_ADD

  

  