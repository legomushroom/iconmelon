define 'views/pages/main', ['views/pages/PageView', 'views/IconSelectView', 'models/IconSelectModel', 'underscore', 'hammer', 'tween'],( PageView, IconSelectView, IconSelectModel, _, hammer, TWEEN)->

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
			
			_.defer =>
				!App.mainAnimated and @animate()
				App.mainAnimated and @show()

			@hammerTime()
			@

		hammerTime:->
			$el = @$('#js-main-logo-icon')
			maxDeg = 20
			deg = 0
			prefix = @prefix()

			hammer(@$el[0]).on 'drag', (e)=> 
				TWEEN.removeAll()
				deg = e.gesture.deltaX
				deg = if deg >  maxDeg then  maxDeg else deg
				deg = if deg < -maxDeg then -maxDeg else deg
				$el.css "#{prefix}transform", "rotate(#{deg}deg)" 

			hammer(@$el[0]).on 'release', (e)=> 
				twn = new TWEEN.Tween(amount: deg).to({amount: 0}, 2000)
							.easing((t)-> 
								b = Math.exp(-t*5)*Math.cos(Math.PI*2*t*5)
								1 - b
							)
							.onUpdate(-> $el.css '-webkit-transform', "rotate(#{@amount}deg)" ).start()
				twn.start()
				@animateA()




		animateA:->
			requestAnimationFrame => @animateA()
			TWEEN.update();

		prefix: ->
			styles = window.getComputedStyle(document.documentElement, "")
			pre = (Array::slice.call(styles).join("").match(/-(moz|webkit|ms)-/) or (styles.OLink is "" and ["", "o"]))[1]
			dom = ("WebKit|Moz|MS|O").match(new RegExp("(" + pre + ")", "i"))[1]
			"-" + pre + "-"


		download:->
			if App.iconsSelected.length is 0
				App.notifier.show
					type: 'error'
					text: 'select at least one icon to download'
				return

			@$downloadBtn = @$('.js-download')
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

		teardown:->
			@iconSelectView.teardown()
			super
			@
	Main















