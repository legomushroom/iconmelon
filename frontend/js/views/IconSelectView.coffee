define 'views/IconSelectView', ['views/ProtoView', 'collectionViews/SectionsCollectionView', 'collections/SectionsCollection', 'collectionViews/FiltersCollectionView', 'collections/FiltersCollection', 'underscore', 'jquery' , 'helpers'], (ProtoView, SectionsCollectionView, SectionsCollection, FiltersCollectionView, FiltersCollection, _, $, helpers)->
	class IconSelectView extends ProtoView
		template: '#icon-select-view-template'
		className: ''

		events:
			'keyup': 									'debouncedFilter'
			'click #js-add-effects': 	'toggleEffects'
			'click #js-next': 				'next'
			'click #js-prev': 				'prev'
			'click #js-page': 				'loadPage'

		initialize:(@o={})->
			@paginationTemplate 		= _.template helpers.unescape $("#pagination-template").text()
			@buttonCounterTemplate 	= _.template helpers.unescape $("#button-counter-template").text()
			@bindModelEvents()
			@debouncedFilter = 	_.debounce @filter, 250
			super
			@sectionsCollection.on 'sync', _.bind @renderPagination, @
			@

		next:->
			@scrollTop(); _.defer => @sectionsCollection.nextPage()
		prev:->
			@scrollTop(); _.defer => @sectionsCollection.prevPage()
		scrollTop:->
			App.$bodyHtml.animate 'scrollTop': @$el.position().top

		loadPage:(e)->
			@sectionsCollection.loadPage parseInt($(e.target).text(), 10) or 0


		toggleEffects:->
			@$('#js-filter-block').show().addClass('animated fadeInDown').find('#js-filters-place').trigger 'show'
			@$el.addClass 'is-filter-show'

		filter:(e)->
			App.vent.trigger 'icon-select-filter:change', $.trim $(e.target).val()

		bindModelEvents:->
			@model.on 'change:selectedCounter', _.bind @renderButton, @

		render:->
			super
			@renderView()
			@$paginationPlace = @$('#js-pagination-place')

			@initFileUpload()

			@renderButton()
			@

		renderPagination:->
			@$paginationPlace.html @paginationTemplate @sectionsCollection.pageInfo()

		renderView:->
			@filtersCollectionView = new FiltersCollectionView
				collection: new FiltersCollection
				isRender: true
				$el: @$('#js-filters-place')

			@filtersCollectionView.collection.fetch()

			@sectionsCollection = new SectionsCollection
			@sectionsCollection.fetch().then =>
				@sectionsCollectionView = new SectionsCollectionView
					collection: @sectionsCollection
					isRender: true
					$el: @$('#js-section-collections-place')

				App.sectionsCollectionView = @sectionsCollectionView 

				@model.sectionsView = @sectionsCollectionView

			@

		renderButton:->
			@$('.icon-set-l').replaceWith @buttonCounterTemplate @model.toJSON()

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
					@parseFile data.result
					@filesLoaded is @filesDropped and @finishFilesLoading()

				error:(e, data)->
					App.notifier.show
						text: 'loading error'
						type: 'error'
				progressall:(e, data)=>
					progress = parseInt(data.loaded / data.total * 100, 10)
					App.$loadingLine.css 'width':"#{progress}%"

		finishFilesLoading:()->
			setTimeout =>
				App.$loadingLine.fadeOut(100,=>
					App.$loadingLine.width "0%"
					App.$loadingLine.show())
			, 2000

		parseFile:(file)->
			parsedFile = file.match(/(data\-iconmelon\s?=\s?\")(.+?)\"/gi)
			sections = {}
			for icon, i in parsedFile
				icon = icon.split('data-iconmelon')[1].replace(/[\"\=]/gi, '')
				icon = icon.split ':'
				sections[icon[0]] ?= []
				sections[icon[0]].push icon[1]
			
			@checkLoadedIcons sections

		checkLoadedIcons:(sections)->
			for sectionName, icons of sections
				if sectionName isnt 'filter'
					sectionModels = @sectionsCollectionView.collection.where 'name': sectionName
					for sectionModel, i in sectionModels
						for icon, j in icons
							icon = sectionModel.iconsCollection.where('hash': icon)[0]
							icon.set 'isSelected', true
				else
					for filter, i in icons
						@filtersCollectionView.collection.where('hash': filter)[0].set 'isSelected', true

	IconSelectView