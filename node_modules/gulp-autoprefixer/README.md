gulp-autoprefixer
===========

[Autoprefixer](https://github.com/ai/autoprefixer) for [gulp](https://github.com/wearefractal/gulp).

    var prefix = require('gulp-autoprefixer');


Example
-------
    
	gulp.src('./css/*.css')
	.pipe(prefix("last 1 version", "> 1%", "ie 8", "ie 7"))
	.pipe(gulp.dest('./dist/'))



License
-------

MIT
