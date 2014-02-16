var should = require('should');
var gutil = require('gulp-util');
var stylus = require('../');
var fs = require('fs');

require('mocha');

describe('gulpstylus', function(){
	it('should render stylus .styl to CSS .css', function(done){
		var stylusStream = stylus();

		var fakeFile = new gutil.File({
			base: 'test/fixtures',
			cwd: 'test/',
			path: 'test/fixtures/normal.styl',
			contents: fs.readFileSync('test/fixtures/normal.styl')
		});

		stylusStream.once('data', function(newFile){
			should.exist(newFile);
			should.exist(newFile.contents);
			String(newFile.contents).should.equal(fs.readFileSync('test/expected/normal.css', 'utf8'));
			done();
		});
		stylusStream.write(fakeFile);

	});

	it ('should uitlize nib when possible', function(done){
		var stream = stylus({use: ['nib']});
		var fakeFile = new gutil.File({
			base: 'test/fixtures',
			cwd: 'test/',
			path: 'test/fixtures/nib-using.styl',
			contents: fs.readFileSync('test/fixtures/nib-using.styl')
		});

		stream.on('data', function(newFile) {
			should.exist(newFile);
			should.exist(newFile.contents);

			String(newFile.contents).should.equal(fs.readFileSync('test/expected/nib-using.css', 'utf8'));
			done();
		});

		stream.write(fakeFile);
		stream.end();
	});

	it ('should import when .use is defined', function(done){
		var stream = stylus({use: ['nib']});
		var fakeFile = new gutil.File({
			base: 'test/fixtures',
			cwd: 'test/',
			path: 'test/fixtures/nib-use-import.styl',
			contents: fs.readFileSync('test/fixtures/nib-use-import.styl')
		});

		stream.on('data', function(newFile) {
			should.exist(newFile);
			should.exist(newFile.contents);
			String(newFile.contents).should.equal(fs.readFileSync('test/expected/nib-use-import.css', 'utf8'));
			done();
		});

		stream.write(fakeFile);
		stream.end();
	});

	it ('should compress when called', function(done){
		var stream = stylus({set: ['compress']});
		var fakeFile = new gutil.File({
			base: 'test/fixtures',
			cwd: 'test/',
			path: 'test/fixtures/normal.styl',
			contents: fs.readFileSync('test/fixtures/normal.styl')
		});

		stream.on('data', function(newFile) {
			should.exist(newFile);
			should.exist(newFile.contents);

			String(newFile.contents).should.equal(fs.readFileSync('test/expected/compressed.css', 'utf8'));
			done();
		});

		stream.write(fakeFile);
		stream.end();
	});
	
	it ('should import other .styl files', function(done){
		var stream = stylus({import: ['one.styl']});
		var fakeFile = new gutil.File({
			base: 'test/fixtures',
			cwd: 'test/',
			path: 'test/fixtures/normal.styl',
			contents: fs.readFileSync('test/fixtures/normal.styl')
		});

		stream.on('data', function(newFile) {
			should.exist(newFile);
			should.exist(newFile.contents);

			String(newFile.contents).should.equal(fs.readFileSync('test/expected/imported.css', 'utf8'));
			done();
		});

		stream.write(fakeFile);
		stream.end();
	});

	it ('should compile inline-image files', function(done){
		var stream = stylus({urlFunc: ['inline-image']});
		var fakeFile = new gutil.File({
			base: 'test/fixtures',
			cwd: 'test/',
			path: 'test/fixtures/urlfunc.styl',
			contents: new Buffer(fs.readFileSync('test/fixtures/urlfunc.styl'))
		});

		stream.on('data', function(newFile) {
			should.exist(newFile);
			should.exist(newFile.contents);

			String(newFile.contents).should.equal(fs.readFileSync('test/expected/urlfunc.css', 'utf8'));
			done();
		});

		stream.write(fakeFile);
		stream.end();
	});
});