define 'views/pages/main', ['views/pages/PageView', 'views/IconSelectView', 'models/IconSelectModel'],( PageView, IconSelectView, IconSelectModel )->

	class Main extends PageView
		template: '#main-template'
		className: "cf"
		initialize:->
			super
			@

		render:->
			super

			@iconSelectView = new IconSelectView
				model: new IconSelectModel
				$el: @$ '#js-icons-select-view-place'
				isRender: true

			@

	Main















