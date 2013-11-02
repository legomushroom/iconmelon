define 'router', ['backbone','controllers/PagesController'], (B, pc)->
	class Router extends B.Router
		routes:
			'': 			'main'
			'submit': 		'submit'
			'editr': 		'editr'

		main:->
			@startPage pc.main
			@chechMainMenuItem()
			@animateHeader()

		submit:->
			@startPage pc.submit
			@chechMainMenuItem '#js-submit'
			@showHeader()


		editr:->
			@startPage pc.editr
			@chechMainMenuItem '#js-editr'
			@showHeader()


		startPage:(View)->
			if @currentPage is View then return
			@currentPage = View
			App.main.show new View @o
			App.$bodyHtml.animate 'scrollTop': 0

		animateHeader:->
			setTimeout =>
				App.$mainHeader.addClass 'animated fadeInDown'
			, 1000

		showHeader:->
			App.$mainHeader.css('opacity': 1).addClass 'no-animation'

		chechMainMenuItem:(selector)->
			App.$mainHeader.find('a').removeClass('is-check').filter(selector).addClass('is-check')

	Router