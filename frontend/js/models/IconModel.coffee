define 'models/IconModel', ['models/ProtoModel'], (ProtoModel)->
	class IconModel extends ProtoModel
		defaults:
			isSelected: false
			isFiltered: false
			hover: 	false
			active: false
			focus: 	false
			hash: '9e78a293b56b43a69cf374ae4ad9f495'
			name: 'icon name'

		toggleSelected:->
			@toggleAttr 'isSelected'

			@collection.selectedCnt ?= 0
			if @get 'isSelected' then @collection.selectedCnt++ else @collection.selectedCnt--

			App.vent.trigger 'icon:select'

	IconModel