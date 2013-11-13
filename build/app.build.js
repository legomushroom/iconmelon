 // 2. the command line to run:
// $ node r.js -o app.build.js

({
	//- paths are relative to this app.build.js file
	appDir: "../frontend",
	baseUrl: "js",
	//- this is the directory that the new files will be. it will be created if it doesn't exist
	dir: "../dist",
	optimizeCss: "standard",
      optimize: "uglify",
      preserveLicenseComments: false,
	paths: {
            jquery: 'lib/jquery-2.0.1',
            backbone: 'lib/backbone',
            underscore: 'lib/lodash.underscore',
            marionette: 'lib/backbone.marionette',
            babysitter: 'lib/backbone.babysitter',
            wreq: 'lib/backbone.wreqr',
            socketio: 'lib/socket.io',
            backboneiosync: 'lib/backbone.iosync',
            backboneiobind: 'lib/backbone.iobind',
            fileupload: 'lib/jquery.fileupload',
            'jquery.ui.widget': 'lib/jquery.ui.widget',
            stickIt: 'lib/backbone.stickit',
            md5: 'lib/md5',
      },
      modules:[
            {name: "main"},
      ],
      
	fileExclusionRegExp: /\.git/
})