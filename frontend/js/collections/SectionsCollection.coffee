define 'collections/SectionsCollection', ['collections/PaginatedCollection', 'models/SectionModel'], (PagenatedCollection, SectionModel)=>
	class SectionsCollection extends PagenatedCollection
		model: SectionModel
		url: 'sections'
	SectionsCollection