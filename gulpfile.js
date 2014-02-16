var gulp 					= require('gulp');
var minifycss 		= require('gulp-minify-css');
var stylus 				= require('gulp-stylus');
var autoprefixer 	= require('gulp-autoprefixer');
var notify 				= require('gulp-notify');
var livereload 		= require('gulp-livereload');
var coffee 				= require('gulp-coffee');
var changed 			= require('gulp-changed');
var jade 					= require('gulp-jade');

var devFolder 	= 'dev/';
var distFolder  = 'dist/';

var paths = {
	src: {
		js:  			devFolder + 'js/**/*.coffee',
		css: 			devFolder + 'css/**/*.styl',
		kit: 			devFolder + 'css/kit.jade',
		index: 		devFolder + 'index.jade',
		partials: devFolder + 'css/partials/**/*.jade',
		templates:devFolder + 'templates/**/*.jade'
	},
	dist:{
		js:  			distFolder + 'js/',
		css: 			distFolder + 'css/',
		kit: 			distFolder + 'css/',
		index: 		distFolder
	}
}

gulp.task('stylus', function(){
	return gulp.src(devFolder + 'css/main.styl')
					.pipe(stylus())
					.pipe(autoprefixer('last 4 version'))
					.pipe(minifycss())
					.pipe(gulp.dest(paths.dist.css))
					.pipe(livereload())
					.pipe(notify('css ready'))
});


gulp.task('coffee', function(e){
	return gulp.src(paths.src.js)
					.pipe(changed(paths.dist.js))
					.pipe(coffee())
					.pipe(gulp.dest(paths.dist.js))
					.pipe(livereload())
					.pipe(notify('js ready'))
});

gulp.task('kit:jade', function(e){
	return gulp.src(paths.src.kit)
					.pipe(jade({pretty:true}))
					.pipe(gulp.dest(paths.dist.kit))
					.pipe(livereload())
					.pipe(notify('kit:jade ready'))
});

gulp.task('index:jade', function(e){
	return gulp.src(paths.src.index)
					.pipe(jade({pretty:true}))
					.pipe(gulp.dest(paths.dist.index))
					.pipe(livereload())
					.pipe(notify('index:jade ready'))
});



gulp.task('default', function(){
	var server = livereload();

	gulp.watch(paths.src.css, function(e){
		gulp.run('stylus');
		server.changed(e.path)
	});

	gulp.watch(paths.src.js, function(e){
		gulp.run('coffee');
		server.changed(e.path)
	});

	gulp.watch(paths.src.kit, function(e){
		gulp.run('kit:jade');
		server.changed(e.path);
	});

	gulp.watch(paths.src.index, function(e){
		gulp.run('index:jade');
		server.changed(e.path);
	});

	gulp.watch(paths.src.partials, function(e){
		gulp.run('kit:jade');
		gulp.run('index:jade');
		server.changed(e.path);
	});

	gulp.watch(paths.src.templates, function(e){
		gulp.run('index:jade');
		server.changed(e.path);
	});

});











