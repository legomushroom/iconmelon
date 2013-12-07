define 'controllers/PagesController', [
	'views/pages/main',
	'views/pages/submit',
	'views/pages/editr',
	'views/pages/support',
	'views/pages/how',
	'views/pages/hire',
	# 'views/pages/terms',
	], (main, submit, editr, support, how, hire, terms)->
		class Controller 
			constructor:->
				@main 	= main
				@submit = submit
				@editr  = editr
				@support= support
				@how  	= how
				@hire  	= hire
				# @terms  = terms

		new Controller
