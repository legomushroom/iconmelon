define 'collectionViews/IconsCollectionView', ['collectionViews/ProtoCollectionView', 'views/IconView', 'jquery'], (ProtoView, IconView, $)->
	class IconsCollectionView extends ProtoView
		itemView: IconView
		template: '#icons-collection-view-template'

		initialize:(@o={})->
			@collection.mode = @o.mode
			super
			@

		# render:->
		# 	super @items = @children.toArray()
		# 	@fadeInAll()
		# 	@

		# fadeInAll:(i=0)->
		# 	if i < @items.length 
		# 		@items[i].$el.fadeIn('fast') 
		# 		setTimeout => 
		# 			@fadeInAll i
		# 		, 15
		# 		i++

	IconsCollectionView

