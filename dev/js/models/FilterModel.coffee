define 'models/FilterModel', ['models/ProtoModel'], (ProtoModel)->
	class FilterModel extends ProtoModel
		defaults:
			iconHash: 'tick-icon'
		toggleSelected:->
			@toggleAttr 'isSelected'

	FilterModel
