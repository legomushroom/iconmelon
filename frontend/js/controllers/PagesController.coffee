define 'controllers/PagesController', [
	'views/pages/main',
	'views/pages/submit',
	'views/pages/editr',
	'views/pages/support',
	], (main, submit, editr, support)->
		class Controller 
			constructor:->
				@main 	= main
				@submit = submit
				@editr  = editr
				@support  = support

		new Controller
