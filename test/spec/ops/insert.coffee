define ['ops/insert'], (Insert) ->
  describe 'ops/insert', ->
    it 'should trigger "op.insert" event when created', (done) ->
      
      PubSub.subscribe 'op.insert', (e, data) ->
        done()
      
      new Insert()

      