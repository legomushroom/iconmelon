require.config
	paths:
		jquery: 		'lib/jquery-2.0.1'
		backbone: 		'lib/backbone'
		underscore: 	'lib/lodash.underscore'
		marionette:		'lib/backbone.marionette'
		babysitter:		'lib/backbone.babysitter'
		wreq:					'lib/backbone.wreqr'
		socketio:			'lib/socket.io'
		backboneiosync:	'lib/backbone.iosync'
		backboneiobind:	'lib/backbone.iobind'
		Modernizr: 		'lib/Modernizr'
		hammer: 			'lib/jquery.hammer'
		baresize: 		'lib/jquery.ba-resize'
		fileupload: 	'lib/jquery.fileupload'
		'jquery.ui.widget':'lib/jquery.ui.widget'
		stickIt: 		'lib/backbone.stickit'
		md5: 				'lib/md5'
		text: 			'lib/text'
		themes: 		'../themes.js'

	shim:
		stickIt:
			deps: 	['backbone']

		backbone:
			exports: 'Backbone'
			deps: 	['jquery','underscore']

		backboneiosync:
			exports: 'Backbone'
			deps: ['backbone', 'socketio']

		backboneiobind:
			exports: 'Backbone'
			deps: ['backboneiosync']

		marionette: 
			exports: 'Backbone.Marionette'
			deps: 	['stickIt']

		baresize:
			deps: 	['jquery']

define 'main', ['collectionViews/NotiesCollectionView', 'marionette', 'jquery', 'router', 'socketio', 'helpers' ], (Notyfier, M, jquery, Router, io, helpers)->
	
	class Application
		constructor:->
			App = new M.Application()
			window.App = App
			App.addRegions
				main: 	'#main-l'

			@$mainHeader  = $('#js-main-header')
			@$loadingLine = $('#js-loadin-line')
			
			App.$loadingLine 	= @$loadingLine
			App.$mainHeader 	= @$mainHeader
			App.$bodyHtml 		= $('body, html')
			App.$svgWrap 			= $('#js-svg-wrap')
			App.helpers 			= helpers
			App.loadedHashes 	= []

			App.iconsSelected 	= []
			App.filtersSelected = []

			
			window.socket = io.connect('http://localhost')
			# window.socket = io.connect('http://legomushroom-iconmelon.jit.su')

			App.router = new Router
			Backbone.history.start()
			App.start()
			App.helpers.listenLinks()

			App.$window = $(window)
			@$mainHeader = $('#js-main-header')
			App.$blinded = $('#js-blinded')

			@listenEvents()
			@makeNotyfier()

		makeNotyfier:->
			App.notifier = new Notyfier
				isRender: true

		listenEvents:->
			App.$window.on 'scroll', =>
				@$mainHeader.toggleClass 'is-convex', App.$window.scrollTop() > 0

	new Application
