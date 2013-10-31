define 'models/SectionModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class SectionModel extends ProtoModel
		url: 'section'
		defaults:
			name: 	 ''
			author:  ''
			email: 	 ''
			website: ''
			license: false
			isClosed: false
			moderated: false
			icons: []


		initialize:(@o={})->
			super
			@


	SectionModel