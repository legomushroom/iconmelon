define 'views/pages/hire', [ 'views/pages/PageView' ], (PageView)->

	class Hire extends PageView
		template: '#hire-page-template'
		className: 'hire-p'
		
		render:->
			super; @loadImage()
			@
		loadImage:->
			imageObj = new Image(); imageObj.onload = => @$('#js-lego-img').addClass('animate fadeInUp').removeClass('op-0-gm')
			imageObj.src = if window.devicePixelRatio > 1 then 'css/i/legomushroom-@2x.png' else 'css/i/legomushroom.png'

	Hire















