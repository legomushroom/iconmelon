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
				collection: new SectionsCollection []
			
			@collectionLine.collection.url = 'sections-all'
			@collectionLine.collection.fetch().then =>
				model = @collectionLine.collection.at(0).set 'isSelected', true
				@setEditTo model

			@collectionLine.collection.onSelect = (model)=>
				@setEditTo model
		setEditTo:(model)->
			@editCollectionView.model.unset().set model.toJSON()
			@editCollectionView.render()

		renderEditCollectionView:->
			@editCollectionView = new EditCollectionView
				$el: @$('#js-edit-collection-view-place')
				isRender: true
				model: new IconsCollectionModel


	Edit















