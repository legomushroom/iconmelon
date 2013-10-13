define 'collectionViews/IconsCollectionView', ['collectionViews/ProtoCollectionView', 'views/IconView'], (ProtoView, IconView)->
	class IconsCollectionView extends ProtoView
		itemView: IconView
		template: '#icons-collection-view-template'
	IconsCollectionView

