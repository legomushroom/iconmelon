define 'collectionViews/IconsCollectionView', ['collectionViews/ProtoCollectionView', 'views/IconView', 'jquery'], (ProtoView, IconView, $)->
	class IconsCollectionView extends ProtoView
		itemView: IconView
		template: '#icons-collection-view-template'

		initialize:(@o={})->
			@collection.mode = @o.mode
			super
			@

	IconsCollectionView

