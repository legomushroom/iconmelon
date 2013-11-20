define 'views/IconSelectView', ['views/ProtoView', 'collectionViews/SectionsCollectionView', 'collections/SectionsCollection', 'collectionViews/FiltersCollectionView', 'collections/FiltersCollection', 'fileupload', 'underscore', 'jquery' , 'helpers'], (ProtoView, SectionsCollectionView, SectionsCollection, FiltersCollectionView, FiltersCollection, fileupload, _, $, helpers)->
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
			@sectionsCollection.on 'afterFetch', _.bind @renderPagination, @
			@

		next:->
			@changePageNoty(); _.defer => @sectionsCollection.nextPage()
		prev:->
			@changePageNoty(); _.defer => @sectionsCollection.prevPage()
		scrollTop:->
			App.$bodyHtml.animate 'scrollTop': @$el.position().top
		showLoader:->
			helpers.showLoaderLine('is-long').setLoaderLineProgress 100
		changePageNoty:->
			@showLoader(); @scrollTop()
		loadPage:(e)->
			@changePageNoty()
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

			@renderButton()
			@initFileUpload()
			@

		renderPagination:()->
			helpers.hideLoaderLine 'is-long'
			@checkSelectedSections()

			App.router.navigate if @sectionsCollection.options.page isnt 0 then  "#/page-#{@sectionsCollection.options.page}" else "#/page-loaded"
			_.defer =>
				@$paginationPlace.html @paginationTemplate @sectionsCollection.pageInfo()


		renderView:->
			@filtersCollectionView = new FiltersCollectionView
				collection: new FiltersCollection
				isRender: true
				$el: @$('#js-filters-place')
			@filtersCollectionView.collection.fetch().then =>
				@filtersCollectionView.collection.addSvgFilters()

			@sectionsCollection = new SectionsCollection 
																	isPaginated: true
																	pageNum: @o.pageNum

			@sectionsCollection.fetch().then =>
				@sectionsCollection.generateSvgData()
				@sectionsCollectionView = new SectionsCollectionView
					collection: @sectionsCollection
					isRender: true
					$el: @$('#js-section-collections-place')

				@renderPagination()
				App.sectionsCollectionView = @sectionsCollectionView 

				@model.sectionsView = @sectionsCollectionView

			@

		renderButton:->
			@$('#js-counter-btn-place').html @buttonCounterTemplate @model.toJSON()

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
			sectionNames = []
			for icon, i in parsedFile
				icon = icon.split('data-iconmelon')[1].replace(/[\"\=]/gi, '')
				icon = icon.split ':'
				sections[icon[0]] ?= []
				sections[icon[0]].push icon[1]
				sectionNames.push icon[0]
			
			@checkLoadedIcons sections, _.uniq sectionNames

		checkSelectedSections:->
			sections = {}
			for icon, i in App.iconsSelected
				icon = icon.split ':'
				sections[icon[0]] ?= []
				sections[icon[0]].push icon[1]

			for sectionName, icons of sections
				for icon, i in icons
					for section, j in @sectionsCollection.where('name': sectionName)
						section.iconsCollection.where('hash': icon)?[0]?.set 'isSelected', true



		checkLoadedIcons:(sections, sectionNames)->
			@loadSections(sectionNames).then => 
				for sectionName, icons of sections
					if sectionName isnt 'filter'
						sectionModels = @sectionsCollectionView.collection.where 'name': sectionName
						for sectionModel, i in sectionModels
							for icon, j in icons
								sectionModel.iconsCollection.where('hash': icon)?[0]?.select()
					else
						for filter, i in icons
							@filtersCollectionView.collection.where('hash': filter)?[0]?.set 'isSelected', true

		loadSections:(sectionNames)->
			@sectionsCollection.fetch(sectionNames: sectionNames).then =>
				@sectionsCollection.generateSvgData()
				@sectionsCollection.options.page = 0
				@sectionsCollection.options.sectionNames = null
				@renderPagination()


	IconSelectView