define 'helpers', ['md5'], (md5)->
	class Helpers

		getRandom:(min,max)->
        	Math.floor((Math.random() * ((max + 1) - min)) + min)

		listenLinks:->
			$(document.body).on 'click', 'a', (e)->
				e.preventDefault()
				$it = $(@)
				# $it = $(@).addClass 'is-check'

				# $it.hasClass('js-nav-link') and $('.js-nav-link').removeClass 'is-check'
				# $it.addClass 'is-check'

				App.router.navigate $it.attr('href'), trigger:true

		normalizeBoolean:(val)->
			(val is 'false') != (Boolean val)

		unescape:(str)->
			str?.replace(/\&lt;/g, '<').replace(/\&gt;/g, '>').replace(/\&quot;/g, '"')

		generateHash:->
			md5 (new Date) + (new Date).getMilliseconds() + Math.random(9999999999999) + Math.random(9999999999999) + Math.random(9999999999999)


	new Helpers


