define ['widget/Simple'], (Simple) ->
  describe 'Simple', ->
    describe '#constructor(text)', ->
      it 'should set client text', ->
        ds = new Simple 
          text: 'A'
        ds.getClientData().should.equal 'A'
        ds.getShadowData().should.equal ''
    
    describe '#getShadowData()', ->
      it 'should return "" on initialize.', ->
        ds = new Simple
        ds.getShadowData().should.equal ''

      it 'should keep a memento of previous values', ->
        ds = new Simple
        ds.setClientData '1'
        ds.getShadowData().should.equal ''
        ds.setClientData '2'
        ds.getShadowData().should.equal '1'
        ds.setClientData '3'
        ds.getShadowData().should.equal '2'