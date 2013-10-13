define 'views/IconSelectView', ['views/ProtoView', 'collectionViews/SectionsCollectionView', 'collections/SectionsCollection', 'underscore', 'jquery' , 'helpers'], (ProtoView, SectionsCollectionView, SectionsCollection, _, $, helpers)->
	class IconSelectView extends ProtoView
		template: '#icon-select-view-template'
		className: ''

		events:
			'keyup': 'filter'

		filter:(e)->
			App.vent.trigger 'icon-select-filter:change', $(e.target).val()

		initialize:(@o={})->
			@buttonCounterTemplate = _.template helpers.unescape $("#button-counter-template").text()
			@bindModelEvents()
			super
			@

		bindModelEvents:->
			@model.on 'change:selectedCounter', _.bind @renderButton, @

		render:->
			super
			@renderButton()
			_.defer =>
				@renderView()
			@

		renderView:->
			@sectionsCollectionView = new SectionsCollectionView
						collection: new SectionsCollection
						isRender: true
						$el: @$('#js-section-collections-place')

			@sectionsCollectionView.collection.fetch()

			@model.sectionsView = @sectionsCollectionView

			@

		renderButton:->
			@$('.btn-b').replaceWith @buttonCounterTemplate @model.toJSON()

	IconSelectView