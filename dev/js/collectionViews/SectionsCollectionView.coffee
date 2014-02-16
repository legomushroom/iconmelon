define 'collectionViews/SectionsCollectionView', ['collectionViews/ProtoCollectionView', 'views/SectionView', 'helpers'], (ProtoView, SectionView, helpers)->
	class SectionsCollectionView extends ProtoView
		itemView: SectionView
		template: '#sections-collection-view-template'

		render:->
			_.defer =>
				super
				@$el.addClass 'animated fadeInDown'
			@

	SectionsCollectionView

