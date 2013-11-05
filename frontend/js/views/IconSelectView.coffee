define 'views/IconSelectView', ['views/ProtoView', 'collectionViews/SectionsCollectionView', 'collections/SectionsCollection', 'collectionViews/FiltersCollectionView', 'collections/FiltersCollection', 'underscore', 'jquery' , 'helpers'], (ProtoView, SectionsCollectionView, SectionsCollection, FiltersCollectionView, FiltersCollection, _, $, helpers)->
	class IconSelectView extends ProtoView
		template: '#icon-select-view-template'
		className: ''

		events:
			'keyup': 'debouncedFilter'
			'click #js-add-effects': 'toggleEffects'

		initialize:(@o={})->
			@buttonCounterTemplate = _.template helpers.unescape $("#button-counter-template").text()
			@bindModelEvents()
			@debouncedFilter = 	_.debounce @filter, 250
			super
			@

		toggleEffects:->
			@$('#js-filter-block').show().addClass('animated fadeInDown').find('#js-filters-place').trigger 'show'
			@$el.addClass 'is-filter-show'

		filter:(e)->
			App.vent.trigger 'icon-select-filter:change', $.trim $(e.target).val()

		bindModelEvents:->
			@model.on 'change:selectedCounter', _.bind @renderButton, @

		render:->
			super
			@renderButton()
			_.defer =>
				@renderView()
			@

		renderView:->
			@filtersCollectionView = new FiltersCollectionView
				collection: new FiltersCollection
				isRender: true
				$el: @$('#js-filters-place')

			@filtersCollectionView.collection.fetch()

			@sectionsCollection = new SectionsCollection
			
			@sectionsCollection.fetch().then =>
				@sectionsCollectionView = new SectionsCollectionView
					collection: @sectionsCollection
					isRender: true
					$el: @$('#js-section-collections-place')

				App.sectionsCollectionView = @sectionsCollectionView 

				@model.sectionsView = @sectionsCollectionView

			@

		renderButton:->
			@$('.icon-set-l').replaceWith @buttonCounterTemplate @model.toJSON()

	IconSelectView