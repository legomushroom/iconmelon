define 'router', ['backbone','controllers/PagesController'], (B, pc)->
	class Router extends B.Router
		routes:
			'': 						'main'
			'submit': 			'submit'
			'editr': 				'editr'
			'support-us': 	'support'
			'how-to-use': 	'how'

		main:->
			@startPage pc.main
			@checkMainMenuItem()
			@animateHeader()

		submit:->
			@startPage pc.submit
			@checkMainMenuItem '#js-submit'
			@showHeader()

		editr:->
			@startPage pc.editr
			@checkMainMenuItem '#js-editr'
			@showHeader()

		support:->
			@startPage pc.support
			@checkMainMenuItem '#js-support-us'
			@showHeader()

		how:->
			@startPage pc.how
			@checkMainMenuItem '#js-how'
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

		checkMainMenuItem:(selector)->
			App.$mainHeader.find('a').removeClass('is-check').filter(selector).addClass('is-check')

	Router