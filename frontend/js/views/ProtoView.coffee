define 'views/ProtoView', ['marionette'], (M)->
	class ProtoView extends M.ItemView

		initialize:(@o={})->
			@o.$el and @setElement @o.$el
			super
			@o.isRender and @render()
			@

		render:->
			super
			@
	ProtoView