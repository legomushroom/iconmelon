var map = require('map-stream');
var stylus = require('stylus');
var gutil = require('gulp-util');
var path = require('path');

module.exports = function (options) {
  var opts = options ? options : {};
  var paths = opts.paths || [];

  function stylusstream (file, cb) {
    // file is on object passed in by gulp
    // TODO: support streaming files
    if (file.isNull()) return cb(null, file); // pass along
    if (file.isStream()) return cb(new Error("gulp-stylus: Streaming not supported"));

    var s = stylus(file.contents.toString('utf8'));
    s.set('filename', file.path);
    s.set('paths', paths.concat([path.dirname(file.path)]));

    //trying to load extensions from array passed by user
    if (opts.use && opts.use.length > 0){
      s.use(function(stylus){
        options.use.forEach(function(args){
          stylus.use(require(args)())
          .import(args);
        });
      });
    }

    if (opts.set && opts.set.length > 0){
      options.set.forEach(function(args){
        s.set(args, true);
      });
    }
    if (opts.import && opts.import.length > 0){
      options.import.forEach(function(args){
        s.import(args);
      });
    }
    if (opts.urlFunc && opts.urlFunc.length > 0) {
      options.urlFunc.forEach(function(args){
        s.define(args, stylus.url());
      });
    }

    s.render(function(err, css){
      if (err) return cb(err);

      file.path = gutil.replaceExtension(file.path, '.css');
      file.contents = new Buffer(css);

      cb(null, file);
    });
  }

  return map(stylusstream);
};