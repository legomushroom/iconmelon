define 'views/NotyView', ['views/ProtoView', 'models/NotyModel', 'underscore', 'jquery' , 'helpers'], (ProtoView, NotyModel, _, $, helpers)->
	class NotyView extends ProtoView
		model: NotyModel
		template: '#noty-view-template'
		className: 'noty-l'

		leftTransitionTime: 250

		events:
			'click': 			'hide'
			'mouseenter': 'stopTimer'
			'mouseleave': 'startTimer'

		initialize:(@o={})->
			@bindModelEvents()
			super
			@

		bindModelEvents:->
			@model.on 'change', @render

		render:->
			super
			@$el.slideDown()
			setTimeout =>
				@$el.addClass 'is-show'
				@startTimer()
			, 400
			@

		startTimer:->
			clearTimeout @timer
			@timer = setTimeout =>
				@hide()
			, @model.get 'delay'
		stopTimer:->
			clearTimeout @timer

		hide:->
			@$el.removeClass 'is-show'
			setTimeout =>
				@model.destroy()
				@teardown()
			, @leftTransitionTime

	NotyView