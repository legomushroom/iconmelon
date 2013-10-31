define 'collectionViews/FiltersCollectionView', ['collectionViews/ProtoCollectionView', 'views/FilterView'], (ProtoView, FilterView)->
	class FiltersCollectionView extends ProtoView
		itemView: FilterView
		template: '#filters-collection-view-template'

		initialize:(@o={})->
			super
			@

		appendHtml:(collectionView, itemView, i)->
    	@$('#js-filters-place').append itemView.el


	FiltersCollectionView

