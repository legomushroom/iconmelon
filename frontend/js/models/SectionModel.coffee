define 'models/SectionModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class SectionModel extends ProtoModel
		url: 'section'
		defaults:
			name: 	 ''
			author:  ''
			email: 	 ''
			webdite: ''
			license: ''
			isClosed: false
			moderated: false
			icons: []


		initialize:->
			# @set 'icons', @generateIcons()

			super
			@

		# generateIcons:->
		# 	for i in [0..helpers.getRandom(10,100)]
		# 		{}

				



	SectionModel