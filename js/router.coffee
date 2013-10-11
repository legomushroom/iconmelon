define 'router', ['backbone','controllers/PagesController'], (B, pc)->
	class Router extends B.Router
		routes:
			'': 			'main'
			'edit': 		'edit'

		main:->
			@startPage pc.main

		edit:->
			@startPage pc.edit

		startPage:(View)->
			App.main.show new View @o

	Router