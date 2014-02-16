var es = require('event-stream');
var coffee = require('coffee-script');
var gutil = require('gulp-util');
var Buffer = require('buffer').Buffer;
var path = require('path');

module.exports = function (opt) {
  function modifyFile(file) {
    if (file.isNull()) return this.emit('data', file); // pass along
    if (file.isStream()) return this.emit('error', new Error("gulp-coffee: Streaming not supported"));

    var str = file.contents.toString('utf8');
    var dest = gutil.replaceExtension(file.path, ".js");

    var options = {
      literate: /\.(litcoffee|coffee\.md)$/.test(file.path)
    };

    if (opt) {
      options = {
        bare: opt.bare != null ? !! opt.bare : false,
        literate: opt.literate != null ? !! opt.literate : options.literate,
        sourceMap: opt.sourceMap != null ? !! opt.sourceMap : false,
        filename: file.path,
        sourceFiles: [path.basename(file.path)],
        generatedFile: path.basename(dest)
      }
    }

    try {
      data = coffee.compile(str, options);
    } catch (err) {
      return this.emit('error', new Error(err));
    }

    if (options.sourceMap) {
      sourceMapFile = new gutil.File({
        cwd: file.cwd,
        base: file.base,
        path: dest + '.map',
        contents: new Buffer(data.v3SourceMap)
      });
      this.emit('data', sourceMapFile);
      data = data.js + "\n/*\n//# sourceMappingURL=" + path.basename(sourceMapFile.path) + "\n*/\n";
    }
    file.contents = new Buffer(data);
    file.path = dest;
    this.emit('data', file);
  }

  return es.through(modifyFile);
};