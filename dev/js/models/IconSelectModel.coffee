define 'models/IconSelectModel', ['models/ProtoModel'], (ProtoModel)->
	class IconSelectModel extends ProtoModel
		defaults:
			selectedCounter: 0

		initialize:->
			App.vent.on 'icon:select', _.bind @refreshCounter, @
			super
			@

		refreshCounter:->
			counter = 0
			@set 'selectedCounter', App.iconsSelected.length + App.filtersSelected.length


	IconSelectModel