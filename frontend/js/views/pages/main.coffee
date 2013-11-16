define 'views/pages/main', ['views/pages/PageView', 'views/IconSelectView', 'models/IconSelectModel', 'underscore'],( PageView, IconSelectView, IconSelectModel, _)->

	class Main extends PageView
		template: '#main-template'
		className: "cf"
		events:
			'click .js-download' : 'download'

		initialize:(@o={})->
			@isNoPageAnima = true
			# @loadSvg()
			super
			@

		# loadSvg:()->
		# 	App.$svgWrap.load 'css/icons-main-page.svg'


		render:->
			super
			@iconSelectView = new IconSelectView
				model: new IconSelectModel
				$el: @$ '#js-icons-select-view-place'
				isRender: true
				pageNum: @o.pageNum

			@$mainLogo 			= @$('.main-logo-b')
			@$melon 				= @$('.logo-large-e')
			@$mainSection 	= @$('#js-icons-select-view-place')
			@$downloadBtn 	= @$('.js-download')
			
			_.defer =>
				!App.mainAnimated and @animate()
				App.mainAnimated and @show()
			@

		download:->
			if App.iconsSelected.length is 0
				App.notifier.show
					type: 'error'
					text: 'select at least one icon to download'
				return

			@$downloadBtn.addClass 'loading-eff'

			$.ajax
				type: 'post'
				url: '/download-icons'
				data:
					icons: 		App.iconsSelected
					filters:	App.filtersSelected
				success:(filename)->
					location.href = "/generated-icons/#{filename}.zip"
				error:(e)->
					console.error e
				complete:=>
					@$downloadBtn.removeClass 'loading-eff'

		animate:->
			@$mainLogo.addClass 'animated fadeInRightBig'
			@$melon.addClass 		'animated swing'
			setTimeout (=> @$mainSection.addClass('animated fadeInDown'); App.mainAnimated = true), 1000

		show:->
			@$mainLogo.addClass 		'is-no-translateX'
			@$melon.removeClass 		'is-rotated'
			@$mainSection.addClass 	'animated fadeInDown'
			@$mainLogo.addClass 		'animated fadeInDown'

	Main















