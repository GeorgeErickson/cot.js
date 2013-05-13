define ['sync/BaseSync'], (BaseSync) ->
  describe 'BaseSync', ->
    afterEach ->
      @bs.destroy()
    describe '#constructor(options)', ->
      it 'options.uuid should be used if provided', ->
        @bs = new BaseSync
          uuid: 'test'

        @bs.uuid.should.equal 'test'

      it 'if options.uuid isnt provided a RFC4122 v4 UUID should be used', ->
        @bs = new BaseSync
        @bs.uuid.length.should.equal 36