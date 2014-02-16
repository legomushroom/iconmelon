/* jshint node:true */

'use strict';

var prefix          = require('autoprefixer'),
    gutil           = require('gulp-util'),
    transform       = require('stream').Transform,
    bufferstreams   = require('bufferstreams'),

    PLUGIN_NAME     = 'gulp-autoprefixer';

function autoprefixerTransform(opts) {
  // Returns a callback that handles the buffered content
  return function(err, buffer, callback) {
    if (err) {
      callback(gutil.PluginError(PLUGIN_NAME, err));
    }
    var prefixed = prefix(opts).process(String(buffer)).css;
    callback(null, new Buffer(prefixed));
  };
}

function gulpautoprefixer() {
  var stream = new transform({ objectMode: true }),
      opts = arguments.length > 0 ? [].slice.call(arguments, 0) : ['> 1%','last 2 versions','ff 17','opera 12.1'];  
  stream._transform = function(file, unused, done) {
    // Pass through if null
    if (file.isNull()) {
      stream.push(file);
      done();
      return;
    } 
    if (file.isStream()) {
      try {
        file.contents = file.contents.pipe(new bufferstreams(autoprefixerTransform(opts)));
      } catch (err) {
        err.fileName = file.path;
        stream.emit('error', new gutil.PluginError('gulp-autoprefixer', err));
      }
      stream.push(file);
      done();
    } else {
      try {
        var prefixed = prefix(opts).process(String(file.contents)).css;
        file.contents = new Buffer(prefixed);
      } catch (err) {
        err.fileName = file.path;
        stream.emit('error', new gutil.PluginError('gulp-autoprefixer', err));
      }
      stream.push(file);
      done();
    }
  };  
  return stream;
}

gulpautoprefixer.autoprefixerTransform = autoprefixerTransform;
module.exports = gulpautoprefixer;
