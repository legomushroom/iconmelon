define 'models/SectionModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class SectionModel extends ProtoModel
		defaults:
			name: 'Section name'
			isClosed: false
			icons: []

		initialize:->
			# @set 'icons', @generateIcons()

			super
			@

		# generateIcons:->
		# 	for i in [0..helpers.getRandom(10,100)]
		# 		{}

				



	SectionModel