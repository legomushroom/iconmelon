define 'collectionViews/SectionsCollectionView', ['collectionViews/ProtoCollectionView', 'views/SectionView'], (ProtoView, SectionView)->
	class SectionsCollectionView extends ProtoView
		itemView: SectionView
		template: '#sections-collection-view-template'
	SectionsCollectionView

