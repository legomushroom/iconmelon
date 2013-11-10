define 'views/pages/how', [ 'views/pages/PageView' ], (PageView)->

	class How extends PageView
		template: '#how-page-template'
		className: 'how-p'

		render:->
			super
			@$el.addClass 'animated fadeInDown'
			@

	How















