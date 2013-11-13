define 'views/pages/PageView', ['views/ProtoView'], (ProtoView)->
	class PageView extends ProtoView

		render:->
			super; !@isNoPageAnima and @animateIn()
			@

		animateIn:->
			@$el.addClass 'animated fadeInDown'

	PageView