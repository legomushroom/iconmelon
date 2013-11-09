define 'collectionViews/SectionsCollectionView', ['collectionViews/ProtoCollectionView', 'views/SectionView'], (ProtoView, SectionView)->
	class SectionsCollectionView extends ProtoView
		itemView: SectionView
		template: '#sections-collection-view-template'

		initialize:->
			super
			@

		render:->
				super
				@$el.addClass 'animated fadeInDown'
				@

		# fadeInAll:(i=0)->
		# 	if i < @items.length 
		# 		@items[i].$el.fadeIn(); setTimeout (=> @fadeInAll i), 250
		# 		i++

	SectionsCollectionView

