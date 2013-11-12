define 'collections/FiltersCollection', ['backbone', 'models/FilterModel'], (B, FilterModel)=>
	class FiltersCollection extends B.Collection
		model: FilterModel
		url: 'filters'
	FiltersCollection