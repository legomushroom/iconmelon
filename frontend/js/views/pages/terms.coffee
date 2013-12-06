define 'views/pages/terms', [ 'views/pages/PageView' ], (PageView)->

	class Terms extends PageView
		template: '#terms-page-template'
		className: 'terms-p'

		initialize:->
			console.log 'init'
			super
			@

	Terms















