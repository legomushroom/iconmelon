define 'views/SectionView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore' ], (ProtoView, SectionModel, IconsCollectionView, IconsCollection, _)->
	class SectionView extends ProtoView
		model: SectionModel
		template: '#section-view-template'
		className: 'section-b cf'

		events: 
			'click #js-hide': 			'toggleHide'
			'click #js-select-all': 	'selectAll'
			'click #js-deselect-all': 	'deSelectAll'

		initialize:->
			@bindModelEvents()
			super
			@


		bindModelEvents:->
			@model.on 'change', @render

		render:->
			super
			_.defer =>
				@renderIcons()

			@$el.toggleClass 'is-closed', !!@model.get('isClosed')
			@$el.toggleClass 'h-gm', 			!!@model.get('isFiltered')
			@

		renderIcons:->
			@iconsCollectionView = new IconsCollectionView
							$el: @$ '#js-icons-place'
							isRender: true
							collection: new IconsCollection @model.get 'icons'

			@iconsCollectionView.collection.onFilter = _.bind @onFilter, @

			@model.iconsCollectionView = @iconsCollectionView

		onFilter:(state)->
			@model.set 'isFiltered', state
		
		selectAll:->
			@iconsCollectionView.collection.selectAll()
			App.vent.trigger 'icon:select'

		deSelectAll:->
			@iconsCollectionView.collection.deSelectAll()
			App.vent.trigger 'icon:select'

		toggleHide:->
			console.log 'toggle hide'
			@model.toggleAttr 'isClosed'

	SectionView