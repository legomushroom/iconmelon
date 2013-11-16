define 'views/IconView', ['views/ProtoView', 'models/IconModel', 'underscore', 'jquery' , 'helpers'], (ProtoView, IconModel, _, $, helpers)->
	class IconSelectView extends ProtoView
		model: IconModel
		template: '#icon-view-template'
		className: 'icon-with-text-b'

		events:
			'click': 'toggleSelected'

		initialize:(@o={})->
			@bindModelEvents()
			super
			@

		bindModelEvents:->
			@model.on 'change', @render

		render:->
			super
			@$el.toggleClass 'is-check', 	@model.get 'isSelected'
			@$el.toggleClass 'h-gm', 		@model.get 'isFiltered'
			@

		toggleSelected:->
			@model.toggleSelected()
			App.iconsSelected = helpers.toggleArray(App.iconsSelected, 	"#{ @model.collection.parentModel.get 'name' }:#{ @model.get 'hash' }")
			console.log App.iconsSelected.length


	IconSelectView