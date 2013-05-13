define ['Events'], (Events) ->
  class PeerSync 
    constructor: (@widget) ->
      @uuid = widget.uuid ? Math.uuid(8, 64)
      @peer = new Peer @uuid,
        host: '18.181.4.144'
        port: 8080
        debug: false
      
      @peer.on 'connection', @attach_events

      
      @peer.on 'open', =>
        #connect to all availible peers
        for p in _.without window.peers, @uuid
          conn = @peer.connect p,
            reliable: true

          @attach_events conn
          

          

    attach_events: (conn) =>
      conn.on 'open', =>
        conn.send
          type: 'sync'
          data:
            uuid: @uuid
            version: @widget.getVersion()
      
      # Send Data when changes occur
      PubSub.subscribe Events.CHANGE, (en, data) ->
        conn.send
          type: 'apply'
          data: data

      conn.on 'data', (resp) =>
        switch resp.type
          when 'apply'
            PubSub.publish Events.APPLY, resp.data

          when 'sync'
            version = @widget.getVersion()
            if version > resp.data.version
              conn.send
                type: 'replace'
                data:
                  uuid: @uuid
                  text: @widget.getClientData()
                  version: version
          
          when 'replace'
            PubSub.publish Events.REPLACE, resp.data


          
        
    
    
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

  

  