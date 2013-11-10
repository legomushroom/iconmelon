define 'controllers/PagesController', [
	'views/pages/main',
	'views/pages/submit',
	'views/pages/editr',
	'views/pages/support',
	'views/pages/how',
	], (main, submit, editr, support, how)->
		class Controller 
			constructor:->
				@main 	= main
				@submit = submit
				@editr  = editr
				@support= support
				@how  	= how

		new Controller
