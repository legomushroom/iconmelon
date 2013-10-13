define 'models/ProtoModel', ['backboneiobind'], (B)->
	class ProtoModel extends B.Model

		toggleAttr:(name)->
			@set name, !@get(name)

	ProtoModel