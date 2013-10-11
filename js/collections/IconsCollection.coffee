define 'collections/IconsCollection', ['backbone', 'models/IconModel'], (B, IconModel)=>
	class IconsCollection extends B.Collection
		model: IconModel
	IconsCollection