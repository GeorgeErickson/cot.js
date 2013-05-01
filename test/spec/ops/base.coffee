define ['ops/base'], (BaseOp) ->
  describe 'ops/base', ->
    it 'should trigger "op.base" event when created', (done) ->
      
      PubSub.subscribe 'op.base', (e, data) ->
        expect(data).to.equal 'test'
        done()
      
      new BaseOp 'test'

      