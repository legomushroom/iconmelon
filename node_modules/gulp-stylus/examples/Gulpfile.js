// include the required packages.
var gulp = require('gulp');
var stylus = require('../');


// Get one .styl file and render
gulp.task('one', function () {
	gulp.src('./css/one.styl')
		.pipe(stylus())
		.pipe(gulp.dest('./css'));
});


// Get all .styl files in one folder and render
gulp.task('one', function () {
	gulp.src('./css/blue/*.styl')
		.pipe(stylus())
		.pipe(gulp.dest('./css/blue'));
});

// Get and render recursive stylus files
gulp.task('stylus', function () {
	gulp.src('./css/**/*.styl')
		.pipe(stylus())
		.pipe(gulp.dest('./css'));
});


// Options
// Options compress
gulp.task('compress', function () {
	gulp.src('./css/compressed/*.styl')
		.pipe(stylus({set: ['compress']}))
		.pipe(gulp.dest('./css/compressed'));
});

// Options linenos
gulp.task('linenos', function () {
	gulp.src('./css/test.styl')
		.pipe(stylus({set: ['linenos']}))
		.pipe(gulp.dest('./css/linenos'));
});

// Option import file
gulp.task('import', function () {
	gulp.src('./css/test.styl')
		.pipe(stylus({import: ['./one.styl']}))
		.pipe(gulp.dest('./css/import'));
});

// Option import file
// import nib
gulp.task('import-nib', function () {
	gulp.src('./css/nib.styl')
		.pipe(stylus({import: ['nib']}))
		.pipe(gulp.dest('./css/import-nib'));
});


// Option use
// Will also import
gulp.task('nib', function(){
	gulp.src('./css/nib.styl')
	.pipe(stylus({use: ['nib']}))
	.pipe(gulp.dest('./css/nib/'));
});

// Option urlFunc
gulp.task('urlfunc', function(){
	gulp.src('./css/urlfunc.styl')
	.pipe(stylus({urlFunc: ['inline-image']}))
	.pipe(gulp.dest('./css/urlfunc/'));
});


// Default gulp task to run
gulp.task('default', ['stylus', 'one']);