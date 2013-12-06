define 'router', ['backbone','controllers/PagesController'], (B, pc)->
	class Router extends B.Router
		routes:
			'': 						'main'
			'/:pageNum': 		'main'
			'submit': 			'submit'
			'editr': 				'editr'
			'support-us': 	'support'
			'how-to-use': 	'how'
			'hire-me': 			'hire'
			'terms': 				'terms'
			'*path': 				'main'

		main:(pageNum='1')->
			pageNum = pageNum.match(/\d/gi)?[0] or 1
			@startPage pc.main, pageNum: ~~pageNum
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

		hire:->
			@startPage pc.hire
			@checkMainMenuItem '#js-hire'
			@showHeader()

		terms:->
			@startPage pc.terms
			# @checkMainMenuItem '#js-terms'
			@showHeader()


		startPage:(View, options={})->
			if @currentPageView is View then return
			@currentPageView = View
			@currentPage?.teardown()
			@currentPage = new View options
			App.main.show @currentPage
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