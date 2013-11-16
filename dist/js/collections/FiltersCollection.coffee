define 'collections/FiltersCollection', ['backbone', 'models/FilterModel', 'helpers'], (B, FilterModel, helpers)=>
	class FiltersCollection extends B.Collection
		model: FilterModel
		url: 'filters'

		addSvgFilters:->
			svgString = ''

			@each (filter)->
				svgString += filter.get('filter').replace /\<filter/, "<filter id='#{filter.get 'hash' }' "
			helpers.addToSvg svgString



	FiltersCollection