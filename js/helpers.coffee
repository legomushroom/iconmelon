define 'helpers', ->
	class Helpers

		listenLinks:->
			$(document.body).on 'click', 'a', (e)->
				e.preventDefault()
				$it = $(@).addClass 'is-check'

				$it.hasClass('js-nav-link') and $('.js-nav-link').removeClass 'is-check'
				$it.addClass 'is-check'

				App.router.navigate $it.attr('href'), trigger:true

		normalizeBoolean:(val)->
			(val is 'false') != (Boolean val)

		unescape:(str)->
			str.replace(/\&lt;/g, '<').replace(/\&gt;/g, '>').replace(/\&quot;/g, '"')


	new Helpers


