define 'views/FilterView', ['views/ProtoView', 'models/FilterModel', 'underscore', 'jquery' , 'helpers'], (ProtoView, FilterModel, _, $, helpers)->
	class FilterView extends ProtoView
		model: FilterModel
		template: '#filter-view-template'
		className: 'filter-b'

		events:
			'click': 'toggleSelected'
			'click #js-left': 'left'
			'click #js-right': 'right'

		initialize:(@o={})->
			@bindModelEvents()
			super
			@

		left:(e)->
			e.stopPropagation()
			@model.set 'iconHash', helpers.getFilterIcon '<'
		right:(e)->
			e.stopPropagation()
			@model.set 'iconHash', helpers.getFilterIcon '>'

		bindModelEvents:->
			@model.on 'change', @render

		render:->
			super
			@$el.toggleClass 'is-check', !!	@model.get 'isSelected'
			@

		toggleSelected:->
			@model.toggleSelected()
			App.filtersSelected = helpers.toggleArray(App.filtersSelected, 	@model.get 'hash')

	FilterView