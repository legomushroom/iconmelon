define 'collectionViews/SectionsCollectionLineView', ['collectionViews/ProtoCollectionView', 'views/SectionLineView'], (ProtoView, SectionLineView)->
	class SectionsCollectionView extends ProtoView
		itemView: SectionLineView
		template: '#sections-collection-line-view-template'

		appendHtml:(collectionView, itemView, i)->
			@$('#js-icons-place').append itemView.el

	SectionsCollectionView

