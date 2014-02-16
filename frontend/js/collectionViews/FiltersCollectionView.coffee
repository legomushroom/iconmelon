define 'collectionViews/FiltersCollectionView', ['collectionViews/ProtoCollectionView', 'views/FilterView', 'underscore'], (ProtoView, FilterView, _)->
	class FiltersCollectionView extends ProtoView
		itemView: FilterView
		template: '#filters-collection-view-template'
		events:
			'click #js-left': 'left'
			'click #js-right': 'right'

		initialize:(@o={})->
			super
			@

		render:->
			super
			@$container   = @$('#js-filters-place')
			@$leftButton  = @$('#js-left')
			@$rightButton = @$('#js-right')
			
			@$el.on 'show', 				 _.bind @detectArrows, @
			App.$window.on 'resize', _.bind @detectArrows, @
			@

		left:->
			@animateScroll -200
		right:->
			@animateScroll  200
		
		animateScroll:(amount)->
			scrollLeft = @$container.scrollLeft()
			@$container.animate 'scrollLeft': @$container.scrollLeft() + amount, => 
				@detectArrows()

		detectArrows:()->
			@$leftButton.toggle  !(@$container.scrollLeft() is 0)
			@$rightButton.toggle ( @$container.scrollLeft() + @$container.outerWidth() < @$container[0].scrollWidth)

		appendHtml:(collectionView, itemView, i)->
    	@$('#js-filters-place').append itemView.el


	FiltersCollectionView

