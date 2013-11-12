define 'collections/SectionsCollection', ['backbone', 'models/SectionModel'], (B, SectionModel)=>
	class SectionsCollection extends B.Collection
		model: SectionModel
		url: 'sections'
	SectionsCollection