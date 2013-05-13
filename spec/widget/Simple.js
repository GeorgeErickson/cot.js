(function() {
  define(['widget/Simple'], function(Simple) {
    return describe('Simple', function() {
      afterEach(function() {
        return this.ds.destroy();
      });
      describe('#constructor(text)', function() {
        return it('should set client text', function() {
          this.ds = new Simple({
            text: 'A'
          });
          this.ds.getClientData().should.equal('A');
          return this.ds.getShadowData().should.equal('');
        });
      });
      return describe('#getShadowData()', function() {
        it('should return "" on initialize.', function() {
          this.ds = new Simple;
          return this.ds.getShadowData().should.equal('');
        });
        return it('should keep a memento of previous values', function() {
          this.ds = new Simple;
          this.ds.setClientData('1');
          this.ds.getShadowData().should.equal('');
          this.ds.setClientData('2');
          this.ds.getShadowData().should.equal('1');
          this.ds.setClientData('3');
          return this.ds.getShadowData().should.equal('2');
        });
      });
    });
  });

}).call(this);
