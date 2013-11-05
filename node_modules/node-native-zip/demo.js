var fs = require("fs");
var zip = require("./index");

//(function () {
//    var archive = new zip();
//    
//    archive.add("hello.txt", new Buffer("Hello world", "utf8"));
//    
//    var buffer = archive.toBuffer();
//    fs.writeFile("./test1.zip", buffer, function () {
//        console.log("Finished");
//    });
//})



(function () {
    var zip = require("./index");
    
    var archive = new zip();
    archive.addFiles([ 
        { name: "test.txt", path: "./test/test.txt" }//,
        //{ name: "images/sam.jpg", path: "./test/images.jpg" }
    ], function () {
        var buff = archive.toBuffer();
        
        fs.writeFile("./test_new.zip", buff, function () {
            console.log("im finished");
        });
    }, function (err) {
        console.log(err);
    });
    //archive.add("smile.txt", new Buffer("Smile!", "utf8"));

}())