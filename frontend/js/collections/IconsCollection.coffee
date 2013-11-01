define 'collections/IconsCollection', ['backbone', 'models/IconModel', 'underscore'], (B, IconModel, _)=>
	class IconsCollection extends B.Collection
		model: IconModel

		initialize:(@o={})->
			@listenToPUBSUB()
			super
			@

		listenToPUBSUB:->
			App.vent.on 'icon-select-filter:change', (filter)=>
				pattern = new RegExp filter, 'gi'
				iconsFiltered = 0
				@each (model)=>
					isFiltered = if !(model.get('name').match pattern) then true else false
					model.set 'isFiltered', isFiltered
					isFiltered and iconsFiltered++

				@filtered = iconsFiltered is @length
				@onFilter @filtered

		selectAll:->
			@setToAll true
			@selectedCnt = @length

		deSelectAll:->
			@setToAll false
			@selectedCnt = 0

		setToAll:(val)->
			@each (model)=>
				if !model.get('isFiltered')
					model.set 'isSelected', val

					hash = model.get 'hash'
					if !val
						App.iconsSelected = _.without App.iconsSelected, hash
					else App.iconsSelected.push hash

			App.iconsSelected = _.uniq App.iconsSelected

	IconsCollection