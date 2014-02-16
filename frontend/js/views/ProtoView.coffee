define 'views/ProtoView', ['marionette'], (M)->
	class ProtoView extends M.ItemView

		initialize:(@o={})->
			@o.$el and @setElement @o.$el
			super
			@o.isRender and @render()
			@

		animateIn:->
			@$el.addClass 'animated fadeInDown'

		teardown:->
			@isClosed 						= true
			@collection?.isClosed = true
			@model?.isClosed			 = true
			@undelegateEvents()


	ProtoView