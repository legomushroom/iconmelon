[![Build Status](https://travis-ci.org/jonathanepollack/gulp-minify-css.png?branch=master)](https://travis-ci.org/jonathanepollack/gulp-minify-css)
## Information

<table>
<tr> 
<td>Package</td><td>gulp-minify-css</td>
</tr>
<tr>
<td>Description</td>
<td>Minify css with <a href="https://github.com/GoalSmashers/clean-css">clean-css.</a></td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.10</td>
</tr>
</table>

## Installion

```
npm install --save-dev gulp-minify-css
```

## Usage

```js
var minifyCSS = require('gulp-minify-css');

gulp.task('minify-css', function() {

  gulp.src('./static/css/*.css')
    .pipe(minifyCSS(opts))
    .pipe(gulp.dest('./dist/'))
});
```
### Options
* `keepSpecialComments` - `*` for keeping all (default), `1` for keeping first one, `0` for removing all
* `keepBreaks` - whether to keep line breaks (default is false)
* `removeEmpty` - whether to remove empty elements (default is false)
* `debug` - turns on debug mode measuring time spent on cleaning up
  (run `npm run bench` to see example)
* `root` - path with which to resolve absolute `@import` rules
* `relativeTo` - path with which to resolve relative `@import` rules

## LICENSE

(MIT License)

Copyright (c) 2013 Jonathan Pollack (<jonathanepollack@gmail.com>), Cloublabs Inc.

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
