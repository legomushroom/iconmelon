require.config
	paths:
		jquery: 		'lib/jquery-2.0.1'
		backbone: 		'lib/backbone'
		underscore: 	'lib/lodash.underscore'
		marionette:		'lib/backbone.marionette'
		babysitter:		'lib/backbone.babysitter'
		wreq:					'lib/backbone.wreqr'
		socketio:			'lib/socket.io'
		'backbone.iosync':	'backbone.iosync'
		'backbone.iobind':	'backbone.iobind'
		fileupload: 	'lib/jquery.fileupload'
		'jquery.ui.widget':'lib/jquery.ui.widget'
		'backbone.stickit': 		'backbone.stickit'
		md5: 				'lib/md5'

	shim:
		'backbone.stickit':
			deps: 	['backbone']

		backbone:
			exports: 'Backbone'
			deps: 	['jquery','underscore']

		'backbone.iosync':
			exports: 'Backbone'
			deps: ['backbone', 'socketio']

		'backbone.iobind':
			exports: 'Backbone'
			deps: ['backbone.iosync']

		marionette: 
			exports: 'Backbone.Marionette'
			deps: 	['backbone.stickit']

define 'main', ['collectionViews/NotiesCollectionView', 'marionette', 'router', 'socketio', 'helpers', 'backbone.iobind', 'backbone.stickit' ], (Notyfier, M, Router, io, helpers)->
	
	class Application
		constructor:->
			App = new M.Application()
			App.name = 'iconmelon'
			window.App = App
			App.addRegions
				main: 	'#main-l'

			@$mainHeader  = $('#js-main-header')
			@$loadingLine = $('#js-loadin-line')
			
			App.$loadingLine 	= @$loadingLine
			App.$mainHeader 	= @$mainHeader
			App.$bodyHtml 		= $('body, html')
			App.$svgWrap 			= $('#js-svg-wrap')
			# @loadSvg()

			App.helpers 			= helpers
			App.loadedHashes 	= []

			App.iconsSelected 	= []
			App.filtersSelected = []

			socketAdress =  if window.location.href.match 'localhost' then 'http://localhost' else 'http://iconmelon.com' 
			window.socket = io.connect socketAdress

			App.$window = $(window)
			@$mainHeader 	= $('#js-main-header')
			App.$blinded 	= $('#js-blinded')
			App.$toTops 	= $('.js-to-top')


			App.router = new Router
			Backbone.history.start()
			App.start()
			App.helpers.listenLinks()


			@listenEvents()
			@makeNotyfier()

		makeNotyfier:->
			App.notifier = new Notyfier
				isRender: true

		listenEvents:->
			App.$window.on 'scroll', =>
				@$mainHeader.toggleClass 'is-convex', App.$window.scrollTop() > 0

			App.$window.on 'scroll', _.throttle( =>
				if App.$window.scrollTop() < App.$window.outerHeight()
					if !@istoTop then return
					App.$toTops.removeClass('animated fadeInUp').addClass('animated fadeOutDown'); 
					@istoTop = false
				else 
					if @istoTop then return
					App.$toTops.removeClass('animated fadeOutDown').addClass('animated fadeInUp'); 
					@istoTop = true
			, 2000)

			App.$toTops.on 'click', => App.$bodyHtml.animate 'scrollTop': 300

		# loadSvg:()->
		# 	App.$svgWrap.load 'css/icons-main-page.svg'

	new Application
