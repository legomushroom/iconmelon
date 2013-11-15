define 'collections/SectionsCollection', ['collections/PaginatedCollection', 'models/SectionModel', 'helpers'], (PaginatedCollection, SectionModel, helpers)=>
	class SectionsCollection extends PaginatedCollection
		model: SectionModel
		url: 'sections'

		afterFetch:->
			@generateSvgData()
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