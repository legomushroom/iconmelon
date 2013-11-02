define 'views/SectionLineView', ['views/ProtoView', 'models/SectionModel', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore', 'helpers' ], (ProtoView, SectionModel, IconsCollectionView, IconsCollection, _, helpers)->
	class SectionView extends ProtoView
		model: SectionModel
		template: '#section-line-view-template'
		className: 'icons-set-b'

		events:
			'click': 'selectMe'

		initialize:->
			@makePreviewSvg()
			@model.on 'change:isSelected', _.bind @render, @
			super
			@

		selectMe:->
			@model.collection.onSelect? @model
			@model.set 'isSelected', true

		makePreviewSvg:->
			i = 0; icons = @model.get('icons')
			$shapes = $('<div>')
			while i < 6
				helpers.upsetSvgShape 
							hash: icons[i]?.hash
							shape: icons[i]?.shape
							$shapes: $shapes
							isMulticolor: @model.get 'isMulticolor'
							# isReset: true
				i++
			helpers.addToSvg $shapes

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
