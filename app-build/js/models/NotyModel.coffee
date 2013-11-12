define 'models/NotyModel', ['models/ProtoModel'], (ProtoModel)->
	class NotyModel extends ProtoModel
		defaults:
			type: 'ok'
			text: ''

	NotyModel
