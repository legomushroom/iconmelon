var fs = require("fs");
var zip = require("./index");




(function () {
    var archive = new zip();
    
    archive.add("hello.txt", new Buffer("Hello world", "utf8"), 'deflate');
    
    var buffer = archive.toBuffer(function(result){
      fs.writeFile("./test1.zip", result, function () {
          console.log("Finished");
      });
    });

})();

(function () {
    var zip = require("./index");
    
    var archive = new zip();
    archive.addFiles([ 
        { name: "moehah.txt", path: "./test/moehah.txt", compression: 'store' },
        { name: "images/sam.jpg", path: "./test/images.jpg", compression: 'store' }
    ], function () {
        var buff = archive.toBuffer(function(result){
          fs.writeFile("./test_new.zip", result, function () {
              console.log("im finished");
          });
        });
        

    }, function (err) {
        console.log(err);
    });
    //archive.add("smile.txt", new Buffer("Smile!", "utf8"));

}())