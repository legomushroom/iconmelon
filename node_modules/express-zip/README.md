# express-zip

express-zip allows you to do `res.zip(files)` in [express](http://expressjs.com/), without creating any intermediary files on disk, and in 100% pure node. [![build status](https://secure.travis-ci.org/thrackle/express-zip.png)](http://travis-ci.org/thrackle/express-zip)

```js
var app = require('express')();
var zip = require('express-zip');

app.get('/', function(req, res) {
  res.zip([
    { path: '/path/to/file1.name', name: '/path/in/zip/file1.name' }
    { path: '/path/to/file2.name', name: 'file2.name' }
  ]);
});

app.listen(3000);
```

## Installation

    $ npm install express-zip

## Credits

Borrows heavily from nulltask's [express-csv](https://github.com/nulltask/express-csv), uses
Antoine van Wel's [zipper](https://github.com/wellawaretech/node-zipstream) for the actual zipping.

## License

(The MIT License)

Copyright (c) 2012 Craig McDonald (thrackle) &lt;oss@thrackle.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.