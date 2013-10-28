define 'views/SectionLineView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore' ], (ProtoView, SectionModel, IconsCollectionView, IconsCollection, _)->
	class SectionView extends ProtoView
		model: SectionModel
		template: '#section-line-view-template'
		className: 'icons-set-b'

		events:
			'click': 'selectMe'

		initialize:->
			@model.on 'change:isSelected', _.bind @render, @

		selectMe:->
			@model.collection.onSelect? @model
			@model.set 'isSelected', true

		render:->
			super
			@$el.toggleClass 'is-check', !!@model.get('isSelected')
			@$el.toggleClass 'is-not-moderated', !@model.get('moderated')
			@checkIfSelected()
			@

		checkIfSelected:->
			@model.collection.currentSelectedModel?.set 'isSelected', false
			if @model.get 'isSelected' then @model.collection.currentSelectedModel = @model

	SectionView
