define 'views/pages/editr', [ 	'views/pages/PageView', 'views/EditCollectionView', 'models/SectionModel', 'collections/SectionsCollection', 'collectionViews/SectionsCollectionLineView' ], (PageView, EditCollectionView, IconsCollectionModel, SectionsCollection, SectionsCollectionView)->

	class Edit extends PageView
		template: '#editr-page-template'

		render:->
			super
			@renderEditCollectionView()
			@renderCollectionsLine()
			@

		renderCollectionsLine:->
			@collectionLine = new SectionsCollectionView
				$el: @$('#js-collection-line-place')
				isRender: true
				collection: new SectionsCollection
			
			@collectionLine.collection.url = 'sections-all'
			@collectionLine.collection.fetch().then( => @showFirstModel()).fail (e)=>
				App.notifier.show
					type: 'error'
					text: 'np, sorry'

			@collectionLine.collection.onSelect = (model)=>
				@renderEditCollectionView model
			@collectionLine.collection.on 'remove', _.bind @showFirstModel, @

		showFirstModel:->
			console.log @collectionLine.collection
			@renderEditCollectionView @collectionLine.collection.at(0)?.set 'isSelected', true

		renderEditCollectionView:(model)->
			@editCollectionView?.teardown()
			@editCollectionView = new EditCollectionView
				$el: @$('#js-edit-collection-view-place')
				isRender: true
				model: model or new IconsCollectionModel
				mode: 'edit'


	Edit















