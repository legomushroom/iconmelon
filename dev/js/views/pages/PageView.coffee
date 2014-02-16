define 'views/pages/PageView', ['views/ProtoView'], (ProtoView)->
	class PageView extends ProtoView

		render:->
			super; !@isNoPageAnima and @animateIn()
			@

	PageView