define 'helpers', ['md5'], (md5)->
	class Helpers

		getRandom:(min,max)->
        	Math.floor((Math.random() * ((max + 1) - min)) + min)

    showLoaderLine:(className='')->
    	App.$loadingLine.show().addClass className
    	@

    hideLoaderLine:(className='')->
    	App.$loadingLine.fadeOut 200, ->
    		App.$loadingLine.css('width': '0').removeClass className
    	@

    setLoaderLineProgress:(n)->
    	App.$loadingLine.css 'width': "#{n}%"
    	@

		listenLinks:->
			$(document.body).on 'click', 'a', (e)->
				$it = $(@)
				if $it.attr('target') is '_blank' or $it.attr('href').match(/mailto:/g) or $it.hasClass 'js-no-follow' then return
				e.preventDefault()
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

		getFilterIcon:(direction)->
			@currIconIndex ?= 0
			if direction is '<'
				@currIconIndex--; @currIconIndex < 0 and (@currIconIndex = App.iconsSelected.length - 1)
			else
				@currIconIndex++; @currIconIndex >= App.iconsSelected.length and (@currIconIndex = 0)
				@currIconIndex++; @currIconIndex >= App.iconsSelected.length and (@currIconIndex = 0)
			if App.iconsSelected[@currIconIndex] then App.iconsSelected[@currIconIndex].split(':')[1] else @getStandartIcon direction

		getStandartIcon:(direction)->
			iconsSource = App.sectionsCollectionView.collection.at(0).get 'icons'
			@currStandartIconIndex ?= 0
			if direction is '<'
				@currStandartIconIndex--; @currStandartIconIndex < 0 and (@currStandartIconIndex = iconsSource.length - 1)
			else
				@currStandartIconIndex++; @currStandartIconIndex >= iconsSource.length and (@currStandartIconIndex = 0)
			iconsSource[@currStandartIconIndex]?.hash or 'tick-icon'



		upsetSvgShape:(o)->
			isLoaded = false
			
			if o.isReset
				App.$svgWrap.find("##{o.hash}").remove()

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
					if !o.isMulticolor
						if ($child.attr('fill') isnt 'none')
							$child.removeAttr('fill')
				o.$shapes.append $shape
				App.loadedHashes.push o.hash

		addToSvg:($shapes)->
			data = if $shapes instanceof $ then $shapes.html() else $shapes
			App.$svgWrap.find('#svg-source').append data
			@refreshSvg()

		placeInSvg:(data)->
			hook = 'js-icons-data-place'
			App.$svgWrap.find('#js-icons-data-place').remove()
			svg = App.$svgWrap.html()
			svg = svg.replace /<!-- icons data marker -->/gi, "<!-- icons data marker --><defs id='#{hook}'>#{data}</defs>"
			App.$svgWrap.html svg
			data

		toggleArray:(array, item, isSingle)->
			return undefined  unless array?
			newArray = array.slice(0)
			indexOfItem = _.indexOf(newArray, item)
			if (indexOfItem is -1) then newArray.push(item) else (if (isSingle) then newArray.splice(indexOfItem, 1) else newArray = _.without(newArray, item))
			newArray

		# addSection:(sectionName)->
		# 	App.sectionsSelected = _.uniq(App.sectionsSelected.push(sectionName))

		# removeSection:(sectionName)->
		# 	App.sectionsSelected = App.sectionsSelected.without sectionName


	new Helpers


