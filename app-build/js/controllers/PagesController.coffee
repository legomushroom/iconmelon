define 'controllers/PagesController', [
	'views/pages/main',
	'views/pages/submit',
	'views/pages/editr',
	'views/pages/support',
	'views/pages/how',
	'views/pages/hire',
	], (main, submit, editr, support, how, hire)->
		class Controller 
			constructor:->
				@main 	= main
				@submit = submit
				@editr  = editr
				@support= support
				@how  	= how
				@hire  	= hire

		new Controller
