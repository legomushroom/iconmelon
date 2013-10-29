define 'router', ['backbone','controllers/PagesController'], (B, pc)->
	class Router extends B.Router
		routes:
			'': 			'main'
			'submit': 		'submit'
			'editr': 		'editr'

		main:->
			@startPage pc.main
			@chechMainMenuItem()

		submit:->
			@startPage pc.submit
			@chechMainMenuItem '#js-submit'

		editr:->
			@startPage pc.editr
			@chechMainMenuItem '#js-editr'

		startPage:(View)->
			if @currentPage is View then return
			@currentPage = View
			App.main.show new View @o
			App.$bodyHtml.animate 'scrollTop': 0

		chechMainMenuItem:(selector)->
			App.$mainHeader.find('a').removeClass('is-check').filter(selector).addClass('is-check')

	Router