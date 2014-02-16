define 'views/pages/submit', [ 	'views/pages/PageView', 'views/EditCollectionView', 'models/SectionModel' ], (PageView, EditCollectionView, IconsCollectionModel)->

	class Edit extends PageView
		template: '#submit-page-template'

		render:->
			super
			@renderEditCollectionView()
			@

		renderEditCollectionView:->
			@editCollectionView = new EditCollectionView
				$el: @$('#js-edit-collection-view-place')
				isRender: true
				model: new IconsCollectionModel


	Edit















