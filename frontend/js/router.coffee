define 'router', ['backbone','controllers/PagesController'], (B, pc)->
	class Router extends B.Router
		routes:
			'': 			'main'
			'submit': 		'submit'

		main:->
			@startPage pc.main

		submit:->
			@startPage pc.submit

		startPage:(View)->
			App.main.show new View @o

	Router