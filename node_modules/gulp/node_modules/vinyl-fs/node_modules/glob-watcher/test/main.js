var watch = require('../');
var should = require('should');
var join = require('path').join;
var fs = require('fs');
var rimraf = require('rimraf');

require('mocha');

describe('glob-watcher', function() {
  it('should return a valid file struct via EE', function(done) {
    var expectedName = join(__dirname, "./fixtures/stuff/temp.coffee");
    var fname = join(__dirname, "./fixtures/**/temp.coffee");
    fs.writeFileSync(expectedName, "testing");

    var watcher = watch(fname);
    watcher.on('change', function(evt) {
      should.exist(evt);
      should.exist(evt.path);
      should.exist(evt.type);
      evt.type.should.equal('changed');
      evt.path.should.equal(expectedName);
      watcher.end();
    });
    watcher.on('end', function(){
      rimraf.sync(expectedName);
      done();
    });
    setTimeout(function(){
      fs.writeFileSync(expectedName, "test test");
    }, 125);
  });

  it('should return a valid file struct via callback', function(done) {
    var expectedName = join(__dirname, "./fixtures/stuff/test.coffee");
    var fname = join(__dirname, "./fixtures/**/test.coffee");
    fs.writeFileSync(expectedName, "testing");

    var watcher = watch(fname, function(evt) {
      should.exist(evt);
      should.exist(evt.path);
      should.exist(evt.type);
      evt.type.should.equal('changed');
      evt.path.should.equal(expectedName);
      watcher.end();
    });

    watcher.on('end', function(){
      rimraf.sync(expectedName);
      done();
    });
    setTimeout(function(){
      fs.writeFileSync(expectedName, "test test");
    }, 200);
  });

  it('should not return a non-matching file struct via callback', function(done) {
    var expectedName = join(__dirname, "./fixtures/test123.coffee");
    var fname = join(__dirname, "./fixtures/**/test.coffee");
    fs.writeFileSync(expectedName, "testing");

    var watcher = watch(fname, function(evt) {
      throw new Error("Should not have been called! "+evt.path);
    });

    setTimeout(function(){
      fs.writeFileSync(expectedName, "test test");
    }, 200);

    setTimeout(function(){
      rimraf.sync(expectedName);
      done();
    }, 1500);
  });
});