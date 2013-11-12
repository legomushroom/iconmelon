define 'views/EditCollectionView', [ 'views/ProtoView', 'views/IconEditView', 'collections/IconsCollection', 'collectionViews/IconsCollectionView', 'views/ThanxModalView', 'fileupload','jquery', 'helpers' ], (ProtoView, IconEditView, IconsCollection, IconsCollectionView, ThanxModalView, fileupload, $, helpers)->

	class EditCollectionView extends ProtoView
		template: '#edit-collection-view-template'

		events:
			'click #js-add-icon': 	'addIcon'
			'click .js-submit-btn:not(.is-inactive)': 'submit'
			'click .js-submit-btn.is-inactive': 			'suggestOnSubmition'
			'click .js-delete': 	'delete'
			'click .js-save': 		'save'

		bindings:
			'#js-collection-name': 	
				observe: 	'name'
				onSet: 		'nameSet'

			'#js-author': 	
				observe: 	'author'
				onSet: 		'authorSet'

			'#js-license': 	
				observe: 	'license'
				onSet: 		'licenseSet'

			'#js-email': 	
				observe: 	'email'
				onSet: 		'emailSet'
			
			'#js-website': 	'website'

			'#js-moderated input': 'moderated'
			# '#js-license   input': 
			# 	observe: 'license'
			# 	onSet: 	'licenseSet'

			'#js-multicolor  input':
				observe: 'isMulticolor'
				onSet: 	 'multicolorChange'

		ui:
			submitBtn: '.js-submit-btn'


		initialize:(@o={})->
			super
			@iconsLoaded = []

			@o.mode is 'edit' and @makeSvgData()
			@initFileUpload()
			@

		render:->
			super
			@$submitButton = @$(@ui.submitBtn)
			@o.mode is 'edit' and @$('.collection-credits-b').addClass 'is-edit'
			@renderIconsCollection()
			@stickit()
			@

		multicolorChange:(val)->
			_.defer =>
				@makeSvgData false, true
				_.defer =>
					@renderIcons()
			val

		renderIcons:->
			for view, i in @iconsCollection.children.toArray()
				view.render()

		suggestOnSubmition:(e)->
			App.notifier.show
				type: 'error'
				text: 'You have to fill credentials and have at least one valid icon to make this button active'


		makeSvgData:(isCheck=true, isReset=false)->
			console.time 'svg load'
			@$shapes = $('<div>')
			@iconsCollection.collection.each (model)=>
				helpers.upsetSvgShape 
							hash: model.get('hash')
							$shapes: @$shapes
							shape: model.get 'shape'
							isCheck: isCheck
							isMulticolor: @model.get 'isMulticolor'
							isReset: isReset

			helpers.addToSvg @$shapes
			console.timeEnd 'svg load'


		renderIconsCollection:->
			@iconsCollection = new IconsCollectionView
				itemView: IconEditView
				collection: new IconsCollection if @model.get('icons').length then @model.get('icons') else [{}]
				isRender: true
				$el: @$ '#js-icons-place'
				mode: @o.mode

			@iconsCollection.collection.parentModel = @model

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
			@authorValid = ! if $.trim(val.length) < 3 then true else false
			@$('#js-author').toggleClass 'is-error', !@authorValid
			@checkIfValidCollection()
			val

		emailSet:(val)->
			re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
			@emailValid = re.test val
			@$('#js-email').toggleClass 'is-error', !@emailValid
			@checkIfValidCollection()
			val

		licenseSet:(val)->
			@licenseValid = $.trim(val).length >= 3
			@$('#js-license').toggleClass 'is-error', !@licenseValid
			@checkIfValidCollection()
			val

		checkIfValidCollection:->
			@enableSubmitButton @nameValid and @authorValid and @emailValid and @licenseValid and @isValidCollection()

		isValidCollection:->
			i = 0
			valid = false
			while i < @iconsCollection.collection.models.length
				if @iconsCollection.collection.at(i).get('isValid')
					i = @iconsCollection.collection.models.length
					valid = true
				i++

			valid
			# @iconsCollection.collection.models.filter((model)-> model.get('isValid')).length

		enableSubmitButton:(state)->
			@$submitButton.toggleClass 'is-inactive', !state

		submit:->
			@$submitButton.addClass('loading-eff is-inactive')
			_.defer =>
				@model.set 'icons', @iconsCollection.collection.toJSON()
				@model.save().then( =>
					@$submitButton.removeClass 'loading-eff'
					(new ThanxModalView).onClose = =>

				).fail (err)=>
					@$submitButton.removeClass 'loading-eff is-inactive'

		delete:->
			if confirm('Are you sure?')
				@model.destroy()

		save:->
			_.defer =>
				@model.set 'icons', @iconsCollection.collection.toJSON()
				@model.save().done( =>
					App.notifier.show
						type: 'ok'
						text: 'saved happily'
						delay: 4000
				).fail =>
					App.notifier.show
						type: 'error'
						text: 'saving sadness'
						delay: 4000


		initFileUpload:->
			@$('#fileupload').fileupload
				url: '/file-upload'
				acceptFileTypes: /(\.|\/)(svg)$/i
				dataType: 'text'
				limitMultiFileUploads: 999
				add:(e, data)=>
					@filesDropped = data.originalFiles.length
					@filesLoaded  = 0
					data.submit()
				done:(e, data)=>
					@filesLoaded++
					name = data.files[0].name.split('.svg')[0]
					data = 
						shape: data.result
						name: name
						hash: helpers.generateHash()
						isValid: true

					@iconsLoaded.push data
					@filesLoaded is @filesDropped and @finishFilesLoading()

				error:(e, data)->
					App.notifier.show
						text: 'loading error'
						type: 'error'
				progressall:(e, data)=>
					progress = parseInt(data.loaded / data.total * 100, 10)
					App.$loadingLine.css 'width':"#{progress}%"

		finishFilesLoading:()->
			@modelToRemove = if @iconsCollection.collection.length is 1 and !@isValidCollection() then @iconsCollection.collection.at(0) else null
			@iconsCollection.collection.mode = 'edit'
			@iconsCollection.collection.add @iconsLoaded
			@modelToRemove?.destroy()
			@iconsLoaded = []

			@makeSvgData false

			@checkIfValidCollection()
			_.defer =>
				App.$loadingLine.fadeOut(100,=>
					App.$loadingLine.width "0%"
					App.$loadingLine.show())


	EditCollectionView















