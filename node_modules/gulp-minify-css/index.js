var es = require('event-stream'),
  CleanCSS  = require('clean-css'),
  clone = require('clone'),
  BufferStreams = require('bufferstreams'),
  gutil = require('gulp-util');

// File level transform function
function minifyCSSTransform(opt) {

  // Return a callback function handling the buffered content
  return function(err, buf, cb) {

    // Handle any error
    if(err) cb(gutil.PluginError('minify-css', err));

    // Use the buffered content
    buf = Buffer(new CleanCSS(opt).minify(String(buf)));

    // Bring it back to streams
    cb(null, buf);
  };
}

// Plugin function
function minifyCSSGulp(opt){
  if (!opt) opt = {};

  function modifyContents(file, cb){
    if(file.isNull()) return cb(null, file);

    if(file.isStream()) {

      file.contents = file.contents.pipe(new BufferStreams(minifyCSSTransform(opt)));

      return cb(null, file);
    }

    var newFile = clone(file);

    var newContents = new CleanCSS(opt).minify(String(newFile.contents));
    newFile.contents = new Buffer(newContents);
    cb(null, newFile);
  }

  return es.map(modifyContents);
}

// Export the file level transform function for other plugins usage
minifyCSSGulp.fileTransform = minifyCSSTransform;

// Export the plugin main function
module.exports = minifyCSSGulp;
