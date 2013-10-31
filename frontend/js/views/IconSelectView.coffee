define 'views/IconSelectView', ['views/ProtoView', 'collectionViews/SectionsCollectionView', 'collections/SectionsCollection', 'collectionViews/FiltersCollectionView', 'collections/FiltersCollection', 'underscore', 'jquery' , 'helpers'], (ProtoView, SectionsCollectionView, SectionsCollection, FiltersCollectionView, FiltersCollection, _, $, helpers)->
	class IconSelectView extends ProtoView
		template: '#icon-select-view-template'
		className: ''

		events:
			'keyup': 'filter'

		filter:(e)->
			App.vent.trigger 'icon-select-filter:change', $.trim $(e.target).val()

		initialize:(@o={})->
			@buttonCounterTemplate = _.template helpers.unescape $("#button-counter-template").text()
			@bindModelEvents()
			super
			@

		bindModelEvents:->
			@model.on 'change:selectedCounter', _.bind @renderButton, @

		render:->
			super
			@renderButton()
			_.defer =>
				@renderView()
			@

		renderView:->
			filter2 = 
				hash: 'drop-shadow'
				name: 'drop shadow'
				iconHash: 'tick-icon'

			filter = 
				hash: 'inset-shadow'
				name: 'inset shadow'
				iconHash: 'tick-icon'

			filter3 = 
				hash: 'drop-shadow-color'
				name: 'drop shadow with color'
				iconHash: 'tick-icon'

			@filtersCollectionView = new FiltersCollectionView
				collection: new FiltersCollection
				isRender: true
				$el: @$('#js-filters-place')

			@filtersCollectionView.collection.fetch()

			@sectionsCollectionView = new SectionsCollectionView
				collection: new SectionsCollection
				isRender: true
				$el: @$('#js-section-collections-place')

			@sectionsCollectionView.collection.fetch()

			App.sectionsCollectionView = @sectionsCollectionView 

			@model.sectionsView = @sectionsCollectionView

			@

		renderButton:->
			@$('.icon-set-l').replaceWith @buttonCounterTemplate @model.toJSON()

	IconSelectView