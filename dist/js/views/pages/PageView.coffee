define 'views/pages/PageView', ['views/ProtoView'], (ProtoView)->
	class PageView extends ProtoView

		render:->
			super; !@isNoPageAnima and @$el.addClass 'animated fadeInDown'
			@

	PageView