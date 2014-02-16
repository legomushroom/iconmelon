var coffee = require('../');
var should = require('should');
var coffeescript = require('coffee-script');
var gutil = require('gulp-util');
var fs = require('fs');
var path = require('path');
require('mocha');

var createFile = function (filepath, contents) {
  var base = path.dirname(filepath);
  return new gutil.File({
    path: filepath,
    base: base,
    cwd: path.dirname(base),
    contents: contents
  });
}

describe('gulp-coffee', function() {
  describe('coffee()', function() {
    before(function() {
      this.testData = function (expected, newPath, done) {
        var newPaths = [newPath];

        if (expected.v3SourceMap) {
          newPaths.unshift(newPath + '.map');
          expected = [
            expected.v3SourceMap,
            expected.js + "\n/*\n//# sourceMappingURL=" + path.basename(newPaths[0]) + "\n*/\n"
          ];
        } else {
          expected = [expected];
        }

        return function (newFile) {
          this.expected = expected.shift();
          this.newPath = newPaths.shift();

          should.exist(newFile);
          should.exist(newFile.path);
          should.exist(newFile.relative);
          should.exist(newFile.contents);
          newFile.path.should.equal(this.newPath);
          newFile.relative.should.equal(path.basename(this.newPath));
          String(newFile.contents).should.equal(this.expected);

          if (done && !expected.length) {
            done.call(this);
          }
        }
      };
    });

    it('should concat two files', function(done) {
      var filepath = "/home/contra/test/file.coffee";
      var contents = new Buffer("a = 2");
      var opts = {bare: true};
      var expected = coffeescript.compile(String(contents), opts);

      coffee(opts)
        .on('error', done)
        .on('data', this.testData(expected, "/home/contra/test/file.js", done))
        .write(createFile(filepath, contents));
    });

    it('should emit errors correctly', function(done) {
      var filepath = "/home/contra/test/file.coffee";
      var contents = new Buffer("if a()\r\n  then huh");

      coffee({bare: true})
        .on('error', function(err) {
          err.message.indexOf(filepath).should.not.equal(-1);
          done();
        })
        .on('data', function(newFile) {
          throw new Error("no file should have been emitted!");
        })
        .write(createFile(filepath, contents));
    });

    it('should compile a file (no bare)', function(done) {
      var filepath = "test/fixtures/grammar.coffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var expected = coffeescript.compile(String(contents));

      coffee()
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/grammar.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a file (with bare)', function(done) {
      var filepath = "test/fixtures/grammar.coffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var opts = {bare: true};
      var expected = coffeescript.compile(String(contents), opts);

      coffee(opts)
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/grammar.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a file with source map', function(done) {
      var filepath = "test/fixtures/grammar.coffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var expected = coffeescript.compile(String(contents), {
        sourceMap: true,
        sourceFiles: ['grammar.coffee'],
        generatedFile: 'grammar.js'
      });

      coffee({sourceMap: true})
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/grammar.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a file with bare and with source map', function(done) {
      var filepath = "test/fixtures/grammar.coffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var expected = coffeescript.compile(String(contents), {
        bare: true,
        sourceMap: true,
        sourceFiles: ['grammar.coffee'],
        generatedFile: 'grammar.js'
      });

      coffee({bare: true, sourceMap: true})
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/grammar.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a literate file', function(done) {
      var filepath = "test/fixtures/journo.litcoffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var opts = {literate: true};
      var expected = coffeescript.compile(String(contents), opts);

      coffee(opts)
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/journo.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a literate file (implicit)', function(done) {
      var filepath = "test/fixtures/journo.litcoffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var expected = coffeescript.compile(String(contents), {literate: true});

      coffee()
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/journo.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a literate file (with bare)', function(done) {
      var filepath = "test/fixtures/journo.litcoffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var opts = {literate: true, bare: true};
      var expected = coffeescript.compile(String(contents), opts);

      coffee(opts)
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/journo.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a literate file with source map', function(done) {
      var filepath = "test/fixtures/journo.litcoffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var expected = coffeescript.compile(String(contents), {
        literate: true,
        sourceMap: true,
        sourceFiles: ['journo.litcoffee'],
        generatedFile: 'journo.js'
      });

      coffee({literate: true, sourceMap: true})
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/journo.js", done))
        .write(createFile(filepath, contents));
    });

    it('should compile a literate file with bare and with source map', function(done) {
      var filepath = "test/fixtures/journo.litcoffee";
      var contents = new Buffer(fs.readFileSync(filepath));
      var expected = coffeescript.compile(String(contents), {
        literate: true,
        bare: true,
        sourceMap: true,
        sourceFiles: ['journo.litcoffee'],
        generatedFile: 'journo.js'
      });

      coffee({literate: true, bare: true, sourceMap: true})
        .on('error', done)
        .on('data', this.testData(expected, "test/fixtures/journo.js", done))
        .write(createFile(filepath, contents));
    });
  });
});
