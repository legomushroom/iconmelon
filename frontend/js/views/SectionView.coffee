define 'views/SectionView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore' ], (ProtoView, SectionModel, IconsCollectionView, IconsCollection, _)->
	class SectionView extends ProtoView
		model: SectionModel
		template: '#section-view-template'
		className: 'section-b cf h-gm'

		events: 
			'click #js-hide': 					'toggleHide'
			'click #js-select-all': 		'selectAll'
			'click #js-deselect-all': 	'deSelectAll'
			'click #js-show-more': 		'toggleExpand'

		initialize:->
			@bindModelEvents()
			super
			@


		bindModelEvents:->
			@model.on 'change:isFiltered', 		_.bind @toggleClasses, @
			@model.on 'change:isClosed', 		_.bind @toggleClasses, @
			@model.on 'change:isExpanded', 		_.bind @toggleClasses, @

		render:->
			super

			@renderIcons()
			@toggleClasses()
			@$content = @$('#js-icons-place')
			@animateIn()
			@listenToOverflow()
			@

		listenToOverflow:->
			@$content.overflow
				axis: 'y'

			@$el.on 'overflow', => 
				console.log 'overflow'
				@model.set 'isExpanded', true
			@$el.on 'flow', => 
				console.log 'release'
				@model.set 'isExpanded', false

		toggleExpand:->
			@model.toggleAttr 'isExpanded'

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
			@$el.toggleClass 'is-closed', 			!!@model.get('isClosed')
			@$el.toggleClass 'h-gm', 				!!@model.get('isFiltered')
			@$el.toggleClass 'is-expanded', 		!!@model.get('isExpanded')

			@$('#js-show-more').text  if !!@model.get('isExpanded') then 'show less' else 'show more'

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