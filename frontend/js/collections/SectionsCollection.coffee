define 'collections/SectionsCollection', ['collections/PaginatedCollection', 'models/SectionModel', 'helpers', 'underscore'], (PaginatedCollection, SectionModel, helpers, _)=>
	class SectionsCollection extends PaginatedCollection
		model: SectionModel
		url: 'sections'

		initialize:(@o={})->
			@page = @o.pageNum if @o.pageNum
			@isPaginated = @o.paginated
			@on 'afterFetch', _.bind @generateSvgData, @
			super
			@

		generateSvgData:->
			shapes = ''
			@each (model)=>
				isMulticolor =  model.get 'isMulticolor'
				for icon, i in model.get 'icons'
					icon = "<g id='#{icon.hash}'>#{icon.shape}</g>"
					shapes += if !isMulticolor then (icon.replace(/fill=\"\s?#[0-9A-Fa-f]{3,6}\s?\"/gi, '')) else icon

			helpers.placeInSvg shapes


	SectionsCollection