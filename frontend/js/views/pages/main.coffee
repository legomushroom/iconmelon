define 'views/pages/main', ['views/pages/PageView', 'views/IconSelectView', 'models/IconSelectModel'],( PageView, IconSelectView, IconSelectModel )->

	class Main extends PageView
		template: '#main-template'
		className: "cf"
		initialize:->
			@loadSvg()
			super
			@

		loadSvg:()->
			App.$svgWrap.load 'css/icons-main-page.svg'

		render:->
			super
			@iconSelectView = new IconSelectView
				model: new IconSelectModel
				$el: @$ '#js-icons-select-view-place'
				isRender: true

			@$mainLogo 			= @$('.main-logo-b')
			@$melon 				= @$('.logo-large-e')
			@$mainSection 	= @$('#js-icons-select-view-place')
			!App.mainAnimated and @animate()
			App.mainAnimated and @show()
			@

		animate:->
			@$mainLogo.addClass 'animated fadeInRightBig'
			setTimeout (=> @$melon.addClass('animated swing').removeClass 'is-rotated'), 450
			setTimeout (=> @$mainSection.addClass('animated fadeInDown'); App.mainAnimated = true), 1000

		show:->
			@$mainLogo.addClass 'is-no-translateX'
			@$melon.removeClass 'is-rotated'
			@$mainSection.addClass 	'animated fadeInDown'
			@$mainLogo.addClass 		'animated fadeInDown'

	Main















