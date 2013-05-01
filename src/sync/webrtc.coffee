define ->
  if localStorage.getItem('id')
    peer = new Peer('george', {key: 'p9yxh5qu9y17cik9'})
  else
    peer = new Peer({key: 'p9yxh5qu9y17cik9'})

  peer.on 'open', (id) ->
    console.log id

  peer.on 'connection', (conn) ->
    conn.on 'data', (data) ->
      PubSub.publish 'apply', data

  window.add_peer = (id) ->
    connection = peer.connect id

    PubSub.subscribe 'op', (en, data) ->
      connection.send data
  
  $ ->
    unless localStorage.getItem('id')
      add_peer 'george'    

  

  