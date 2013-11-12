define 'collectionViews/NotiesCollectionView', ['collectionViews/ProtoCollectionView', 'collections/NotiesCollection', 'views/NotyView'], (ProtoCollectionView, NotiesCollection, NotyView)->
	class NotiesCollectionView extends ProtoCollectionView
		itemView: NotyView
		template: '#noties-collection-view-template'

		initialize:(@o={})->
			@setElement $('#js-notifier-place')
			@collection = new NotiesCollection []
			super
			@
		appendHtml:(collectionView, itemView, i)->
			@$el.prepend itemView.el

		show:(data={})->
			defaults = 
				type: 'ok'
				text: 'evrything is ok'
				delay: 7000

			data = defaults extends data
			@collection.add data



	NotiesCollectionView

