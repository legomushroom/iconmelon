define 'views/SectionView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore' ], (ProtoView, SectionModel, IconsCollectionView, IconsCollection, _)->
	class SectionView extends ProtoView
		model: SectionModel
		template: '#section-view-template'
		className: 'section-b cf h-gm'

		events: 
			'click #js-hide': 					'toggleHide'
			'click #js-select-all': 		'selectAll'
			'click #js-deselect-all': 	'deSelectAll'

		initialize:->
			@bindModelEvents()
			super
			@


		bindModelEvents:->
			@model.on 'change:isFiltered', 	_.bind @toggleClasses, @
			@model.on 'change:isClosed', 		_.bind @toggleClasses, @

		render:->
			super

			@renderIcons()
			@toggleClasses()
			@$content = @$('#js-icons-place')
			@animateIn()
			@

		renderIcons:->
			@iconsCollectionView = new IconsCollectionView
							$el: @$ '#js-icons-place'
							isRender: true
							collection: new IconsCollection @model.get 'icons'

			@iconsCollectionView.collection.onFilter = _.bind @onFilter, @
			@iconsCollectionView.collection.parentModel = @model
			@model.iconsCollection 			= @iconsCollectionView.collection
			@model.iconsCollectionView 	= @iconsCollectionView

		toggleClasses:->
			@$el.toggleClass 'is-closed', !!@model.get('isClosed')
			@$el.toggleClass 'h-gm', 			!!@model.get('isFiltered')

		onFilter:(state)->
			@model.set 'isFiltered', state
		
		selectAll:->
			@iconsCollectionView.collection.selectAll()
			App.vent.trigger 'icon:select'

		deSelectAll:->
			@iconsCollectionView.collection.deSelectAll()
			App.vent.trigger 'icon:select'

		toggleHide:->
			@model.toggleAttr 'isClosed'
			@$content.slideToggle()

	SectionView