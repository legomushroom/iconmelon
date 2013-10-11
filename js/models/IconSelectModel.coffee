define 'models/IconSelectModel', ['models/ProtoModel'], (ProtoModel)->
	class IconSelectModel extends ProtoModel
		defaults:
			selectedCounter: 0

	IconSelectModel