#gulp-stylus
[![Build Status](https://travis-ci.org/stevelacy/gulp-stylus.png?branch=master)](https://travis-ci.org/stevelacy/gulp-stylus)
[![NPM version](https://badge.fury.io/js/gulp-stylus.png)](http://badge.fury.io/js/gulp-stylus)

> Compile [Stylus](http://learnboost.github.io/stylus/) with gulp (gulpjs.com)

## Information

<table>
<tr> 
<td>Package</td><td>gulp-stylus</td>
</tr>
<tr>
<td>Description</td>
<td>Stylus plugin for Gulp</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.9</td>
</tr>
<tr>
<td>Gulp Version</td>
<td>3.x</td>
</tr>
</table>

## Usage
#### Install
		npm install gulp-stylus --save

## Examples

```javascript

// Gulpfile.js
// Require the needed packages
var gulp = require('gulp');
var stylus = require('gulp-stylus');


// Get one .styl file and render
gulp.task('one', function () {
	gulp.src('./css/one.styl')
		.pipe(stylus({
			paths: ["/home/stylus-plugins/"], // only needed in special cases,
			set:['compress']
		}))
		.pipe(gulp.dest('./css'));
});


// Get all .styl files in one folder and render
gulp.task('one', function () {
	gulp.src('./css/blue/*.styl')
		.pipe(stylus())
		.pipe(gulp.dest('./css/blue'));
});



// Get and render all .styl files recursively 
gulp.task('stylus', function () {
	gulp.src('./css/**/*.styl')
		.pipe(stylus())
		.pipe(gulp.dest('./css'));
});


// Stylus.use options:
// Use nib
gulp.task('nib', function () {
	gulp.src('./css/nib/*.styl')
		.pipe(stylus({use: ['nib']}))
		.pipe(gulp.dest('./css/'));
});

// Note: 'import:' is no longer needed when using 'use:['nib']' after 0.0.11
// nib usage
gulp.task('nib', function () {
	gulp.src('./css/nib/*.styl')
		.pipe(stylus({
			use: ['nib']}))
		.pipe(gulp.dest('./css/'));
});


// Stylus.set options:
// Option compress
gulp.task('compress', function () {
	gulp.src('./css/compressed/*.styl')
		.pipe(stylus({set:['compress']}))
		.pipe(gulp.dest('./css/compressed'));
});

// Option linenos
gulp.task('linenos', function () {
	gulp.src('./css/linenos/*.styl')
		.pipe(stylus({set:['linenos']}))
		.pipe(gulp.dest('./css/linenos'));
});

// Option import file
gulp.task('import', function () {
	gulp.src('./css/test.styl')
		.pipe(stylus({import: ['./one.styl']})) // the file is Relative to the Other styl files
		.pipe(gulp.dest('./css/import'));
});

// Option urlFunc - inline images
gulp.task('urlfunc', function(){
	gulp.src('./css/urlfunc.styl')
	.pipe(stylus({urlFunc: ['inline-image']}))
	.pipe(gulp.dest('./css/urlfunc/'));
});






// Default gulp task to run
gulp.task('default', ['stylus', 'one']);

```
####You can view more examples in the [example folder.](https://github.com/stevelacy/gulp-stylus/tree/master/examples)


## API


### stylus(options)  

#### options.use
Type: `Array`  
Default: `undefined`  

Array of string representing names of modules which will be used as extensions 
to Stylus (e.g. 'nib'). Modules are required inside of the plugin and invoked.

Options to the stylus stream are passed straight through to the stylus module.

Note: 'import:' is no longer needed when using 'use:['nib']' after 0.0.11
Example:
```javascript
// stylus.use('nib')

.pipe(stylus({use: ['nib']}))
```


#### options.set
Type: `Array`  
Default: `undefined`

Example:
```javascript
// stylus.set(['compress': true ]);
.pipe(stylus({set: ['compress']}))

// stylus.set(['linenos': true]);
.pipe(stylus({set: ['linenos']}))

```

#### options.import
Type: `Array`  
Default: `undefined`

Example:
```javascript
// stylus.import(['./file.styl']);
.pipe(stylus({import:['./file.styl']}))

// stylus.import(['./css/*.css']);
.pipe(stylus({import:['./*.css']}))

```

## LICENSE

(MIT License)

Copyright (c) 2013 Steve Lacy <me@slacy.me> - Fractal <contact@wearefractal.com> wearefractal.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
