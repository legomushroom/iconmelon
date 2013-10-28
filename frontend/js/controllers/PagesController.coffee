define 'controllers/PagesController', [
	'views/pages/main',
	'views/pages/submit',
	'views/pages/editr',
	], (main, submit, editr)->
		class Controller 
			constructor:->
				@main 	= main
				@submit = submit
				@editr  = editr

		new Controller
