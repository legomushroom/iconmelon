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
			@listenToOverflow()
			@


		bindModelEvents:->
			@model.on 'change:isFiltered', 		_.bind @toggleClasses, @
			@model.on 'change:isClosed', 		_.bind @toggleClasses, @
			@model.on 'change:isExpanded', 		_.bind @toggleClasses, @

		render:->
			super

			@renderIcons()
			@$content = @$('#js-icons-place')
			@toggleClasses(false)
			_.defer => @toggleExpandedBtn()
			@animateIn()
			@

		listenToOverflow:-> 	$(window).on 'resize', _.bind @toggleExpandedBtn, @
		
		isExpandBtnNeeded:-> 	@$el.hasClass('is-expanded') or @$content.outerHeight() < @$content[0].scrollHeight
		
		toggleExpand:-> 		@model.toggleAttr 'isExpanded'

		toggleExpandedBtn:-> 	@$el.toggleClass 'is-no-expanded-btn', !@isExpandBtnNeeded()

		onFilter:(state)-> 		@toggleExpandedBtn(); @model.set 'isFiltered', state

		renderIcons:->
			@iconsCollectionView = new IconsCollectionView
							$el: @$ '#js-icons-place'
							isRender: true
							collection: new IconsCollection @model.get 'icons'

			@iconsCollectionView.collection.onFilter = _.bind @onFilter, @
			@iconsCollectionView.collection.parentModel = @model
			@model.iconsCollection 			= @iconsCollectionView.collection
			@model.iconsCollectionView 	= @iconsCollectionView

		toggleClasses:(isToggleBtn=true)->
			@$el.toggleClass 'is-closed', 			!!@model.get('isClosed')
			@$el.toggleClass 'h-gm', 				!!@model.get('isFiltered')
			@$el.toggleClass 'is-expanded', 		!!@model.get('isExpanded')
			isToggleBtn and @toggleExpandedBtn()
			@$('#js-show-more').text  if !!@model.get('isExpanded') then 'show less' else 'show more'

		
		
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