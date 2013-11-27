# node-native-zip

All the current ZIP solutions for node.js are wrappers around existing zip executables, spawning on demand.
To all of you who rather have a native implementation of zip'ing in javascript there is node-native-zip.
This package works with `Buffer` objects, which allows you to do complex in-memory stuff with the least
amount of overhead.

It has been inspired by [JSZip](https://github.com/Stuk/jszip).

## How to install

Via NPM:

    npm install node-native-zip
    
Via GIT:

    git clone git://github.com/janjongboom/node-native-zip.git
    
## How to use

There are two ways to feed files into a new .zip file. Either by adding `Buffer` objects, or by adding
an array of files.

### Adding Buffer objects

    var fs = require("fs");
    var zip = require("node-native-zip");
    
    var archive = new zip();
    
    archive.add("hello.txt", new Buffer("Hello world", "utf8"));
    
    var buffer = archive.toBuffer();
    fs.writeFile("./test1.zip", buffer, function () {
        console.log("Finished");
    });
    
### Adding files from the file system

    var fs = require("fs");
    var zip = require("node-native-zip");
    
    var archive = new zip();
    
    archive.addFiles([ 
        { name: "moehah.txt", path: "./test/moehah.txt" },
        { name: "images/suz.jpg", path: "./test/images.jpg" }
    ], function (err) {
        if (err) return console.log("err while adding files", err);
        
        var buff = archive.toBuffer();
        
        fs.writeFile("./test2.zip", buff, function () {
            console.log("Finished");
        });
    });
    
## API Reference

There are three API methods:

* `add(name, data)`, the 'name' is the name within the .zip file. To create a folder structure, add '/'
* `addFiles(files, callback)`, where files is an array containing objects in the form ` { name: "name/in/zip.file", path: "file-system.path" } `. Callback is a function that takes 1 parameter 'err' which indicates whether an error occured.
* `toBuffer()`, creates a new buffer and writes the zip file to it

## Compression?

The library currently doesn't do any compression. It stores the files via STORE. Main reason is that the
compression call is synchronous at the moment, so the thread will block during compression, something to
avoid.
However, it is possible to add compression methods by implementing the following interface.

    module.exports = (function () {
        return {
            indicator : [ 0x00, 0x00 ],
            compress : function (content) {
                // content is a Buffer object.
                // you have to return a new Buffer too.
            }
        };
    }());

The `indicator` is an array consisting of two bytes indicating the compression technology.
For example: `[ 0x00, 0x00]` is STORE, `[ 0x08, 0x00]` is DEFLATE.

The `compress` function is a method that transforms an incoming `Buffer` into a new one.

The easiest to implement is probably deflate, because there is a [sample](https://github.com/Stuk/jszip/blob/master/jszip-deflate.js)
in JSZip. You will only need to change the inner workings from string-based to Buffer-based.

## Unzipping

Unzipping is more complex because of all the different compression algorithms that you may
encounter in the wild. So it's not covered. Use existing libraries for that.