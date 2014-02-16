define 'helpers', ['md5'], (md5)->
	class Helpers

		isMobile: ->
			check = false
			((a) -> check = true  if /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) or /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))
			) navigator.userAgent or navigator.vendor or window.opera
			check

		prefix: ->
			styles = window.getComputedStyle(document.documentElement, "")
			pre = (Array::slice.call(styles).join("").match(/-(moz|webkit|ms)-/) or (styles.OLink is "" and ["", "o"]))[1]
			dom = ("WebKit|Moz|MS|O").match(new RegExp("(" + pre + ")", "i"))[1]
			"-" + pre + "-"

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


