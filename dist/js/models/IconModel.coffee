define 'models/IconModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class IconModel extends ProtoModel
		defaults:
			isSelected: false
			isFiltered: false
			hover: 	false
			active: false
			focus: 	false
			name: ''
			shape: null
			hash: null
			isNameValid: false
			isShapeValid: false
			isValid: false

		toggleSelected:->
			@toggleAttr 'isSelected'

			@collection.selectedCnt ?= 0
			if @get 'isSelected' then @collection.selectedCnt++ else @collection.selectedCnt--
			App.iconsSelected = helpers.toggleArray(App.iconsSelected, 	"#{ @collection.parentModel.get 'name' }:#{ @get 'hash' }")

			@calcSelected()

		deselect:->
			@select false

		select:(val=true)->
			@.set 'isSelected', val
			if val then App.iconsSelected.push "#{ @collection.parentModel.get 'name' }:#{ @get 'hash' }" 
			else App.iconsSelected = _.without App.iconsSelected, "#{ @collection.parentModel.get 'name' }:#{ @get 'hash' }"
			
			val and (iconsSelected = _.uniq App.iconsSelected )
		
			@calcSelected()
			# if val 
			# 	App.iconsSelected = App.iconsSelected.push "#{ @collection.parentModel.get 'name' }:#{ @get 'hash' }")
			# else
			# 	App.iconsSelected = _.without App.iconsSelected, "#{ @collection.parentModel.get 'name' }:#{ @get 'hash' }")

		calcSelected:->
			App.vent.trigger 'icon:select'

	IconModel
