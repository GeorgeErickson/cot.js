(function() {
  define(['sync/BaseSync'], function(BaseSync) {
    return describe('BaseSync', function() {
      afterEach(function() {
        return this.bs.destroy();
      });
      return describe('#constructor(options)', function() {
        it('options.uuid should be used if provided', function() {
          this.bs = new BaseSync({
            uuid: 'test'
          });
          return this.bs.uuid.should.equal('test');
        });
        return it('if options.uuid isnt provided a RFC4122 v4 UUID should be used', function() {
          this.bs = new BaseSync;
          return this.bs.uuid.length.should.equal(36);
        });
      });
    });
  });

}).call(this);
