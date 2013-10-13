define 'controllers/PagesController', [
	'views/pages/main',
	'views/pages/submit',
	], (main, submit)->
		class Controller 
			constructor:->
				@main 	= main
				@submit 	= submit

		new Controller
