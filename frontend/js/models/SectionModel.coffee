define 'models/SectionModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class SectionModel extends ProtoModel
		url: 'section'
		defaults:
			name: 	 ''
			author:  ''
			email: 	 ''
			website: ''
			license: ''
			isMulticolor: false
			isExpanded: false
			isClosed: false
			moderated: false
			isAgree: false
			icons: []


		initialize:(@o={})->
			super
			@


	SectionModel