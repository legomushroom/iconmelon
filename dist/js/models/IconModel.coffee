define 'models/IconModel', ['models/ProtoModel'], (ProtoModel)->
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

			@calcSelected()

		deselect:->
			@set 'isSelected', false
			@calcSelected()

		select:->
			@set 'isSelected', true
			@calcSelected()

		calcSelected:->
			App.iconsSelected = helpers.toggleArray(App.iconsSelected, 	"#{ @collection.parentModel.get 'name' }:#{ @model.get 'hash' }")
			App.vent.tigger 'icon:select'


	IconModel
