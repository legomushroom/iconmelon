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

		refreshSvg:->
			App.$svgWrap.html App.$svgWrap.html()

		upsetSvgShape:(o)->
			isLoaded = false
			if o.isCheck
				i = 0; 
				while i < App.loadedHashes.length
					if String(App.loadedHashes[i]) is String(o.hash)
						isLoaded = true
						i = App.loadedHashes.length
					i++

			
			if !isLoaded
				$shape = $('<g>').html(o.shape).attr 'id', o.hash
				$shape.find('*').each (i, child)->
					$child = $(child)
					if ($child.attr('fill') isnt 'none')
						$child.removeAttr('fill')
				o.$shapes.append $shape
				App.loadedHashes.push o.hash

		addToSvg:($shapes)->
			App.$svgWrap.find('#svg-source').append $shapes.html()
			@refreshSvg()


	new Helpers


