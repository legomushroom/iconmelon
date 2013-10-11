define 'models/IconModel', ['models/ProtoModel'], (ProtoModel)->
	class IconModel extends ProtoModel
		defaults:
			isSelected: false
			hover: 	false
			active: false
			focus: 	false
			hash: '9e78a293b56b43a69cf374ae4ad9f495'
			name: 'icon name'

		toggleSelected:->
			@set 'isSelected', !@get('isSelected')

	IconModel