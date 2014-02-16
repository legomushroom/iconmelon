define 'models/ProtoModel', ['backbone'], (B)->
	class ProtoModel extends B.Model

		toggleAttr:(name)->
			@set name, !@get(name)

	ProtoModel