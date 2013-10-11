define 'views/IconSelectView', ['views/ProtoView', 'collectionViews/IconsCollectionView', 'collections/IconsCollection', 'underscore', 'jquery' , 'helpers'], (ProtoView, IconView, IconModel, _, $, helpers)->
	class IconSelectView extends ProtoView
		template: '#icon-select-view-template'
		className: ''

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
			@iconView = new IconView
							$el: $ '#js-icon-place'
							isRender: true
							collection: new IconModel [{},{},{},{},{},{},{},{}]

			@

		renderButton:->
			@$('.btn-b').replaceWith @buttonCounterTemplate @model.toJSON()

	IconSelectView