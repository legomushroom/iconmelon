define 'views/EditCollectionView', [ 'views/ProtoView', 'views/IconEditView', 'collections/IconsCollection', 'collectionViews/IconsCollectionView', 'fileupload','jquery', 'helpers' ], (ProtoView, IconEditView, IconsCollection, IconsCollectionView, fileupload, $, helpers)->

	class EditCollectionView extends ProtoView
		template: '#edit-collection-view-template'

		events:
			'click #js-add-icon': 'addIcon'
			'click .js-submit-btn:not(.is-inactive)': 'submit'

		bindings:
			'#js-collection-name': 	
				observe: 	'name'
				onSet: 		'nameSet'

			'#js-author': 	
				observe: 	'author'
				onSet: 		'authorSet'

			'#js-email': 	
				observe: 	'email'
				onSet: 		'emailSet'
			
			'#js-website': 	'website'

		ui:
			submitBtn: '.js-submit-btn'


		initialize:->
			super
			@initFileUpload()
			@

		render:->
			super
			@$submitButton = @$(@ui.submitBtn)
			@renderIconsCollection()
			@stickit()
			@

		renderIconsCollection:->
			@iconsCollection = new IconsCollectionView
				itemView: IconEditView
				collection: new IconsCollection if @model.get('icons').length then @model.get('icons') else [{}]
				isRender: true
				$el: @$ '#js-icons-place'

			App.vent.on 'edit-collection:change', _.bind @checkIfValidCollection, @


		addIcon:->
			@iconsCollection.collection.add {}

		
		# validation
		nameSet:(val)->
			@nameValid = ! if $.trim(val.length) < 1 then true else false
			@$('#js-collection-name').toggleClass 'is-error', !@nameValid
			@checkIfValidCollection()
			val

		authorSet:(val)->
			@authorValid = ! if $.trim(val.length) < 4 then true else false
			@$('#js-author').toggleClass 'is-error', !@authorValid
			@checkIfValidCollection()
			val

		emailSet:(val)->
			re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
			@emailValid = re.test val
			@$('#js-email').toggleClass 'is-error', !@emailValid
			@checkIfValidCollection()
			val

		checkIfValidCollection:->
			@enableSubmitButton @nameValid and @authorValid and @emailValid and @isValidCollection()

		isValidCollection:->
			@iconsCollection.collection.models.filter((model)-> model.get('isValid')).length

		enableSubmitButton:(state)->
			@$submitButton.toggleClass 'is-inactive', !state

		submit:->
			@model.set 'icons', @iconsCollection.collection.toJSON()
			@model.save()

		initFileUpload:->
			@$('#fileupload').fileupload
				url: '/file-upload'
				acceptFileTypes: /(\.|\/)(svg)$/i
				dataType: 'text'
				limitMultiFileUploads: 999
				add:(e, data)=>
					console.log 'upload started...'
					@filesDroppedCnt = data.originalFiles.length
					data.submit()
				done:(e, data)=>
					name = data.files[0].name.split('.svg')[0]
					@filesLoadedCnt ?= 0
					@filesLoadedCnt++
					modelToRemove = if @iconsCollection.collection.length is 1 and !@isValidCollection() then @iconsCollection.collection.at(0) else null
					@iconsCollection.collection.add
							shape: data.result
							name: name
							hash: helpers.generateHash()
							isValid: true

					modelToRemove?.destroy()
					console.log "#{@filesLoadedCnt}/#{@filesDroppedCnt}"
					if @filesDroppedCnt is @filesLoadedCnt then @finishFilesLoading()

				error:(e, data)->
				progressall:(e, data)=>

		finishFilesLoading:()->
			@filesLoadedCnt = 0
			@checkIfValidCollection()
			console.log 'files loaded'


	EditCollectionView















