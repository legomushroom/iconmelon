define 'views/IconEditView', ['views/ProtoView', 'models/IconModel', 'underscore', 'jquery' , 'helpers'], (ProtoView, IconModel, _, $, helpers)->
	class IconEditView extends ProtoView
		model: IconModel
		template: '#icon-edit-view-template'
		
		events:
			'click #js-destroy': 	'destroy'
			'keyup #js-shape': 		'preSetShape'
			'keyup #js-name': 		'preSetName'

		bindings:
			'#js-name': 
				observe: 'name'
				onSet: 'setName'

			'#js-shape':
				observe: 'shape'
				onSet:   'setShape'

		preSetShape:(e)->
			# copy&paste fix
			@setShape $(e.target).val()
			@$('#js-shape').toggleClass 'is-error', !@model.get 'isShapeValid'


		preSetName:(e)->
			@$('#js-name').toggleClass 'is-error', !@model.get 'isNameValid'


		setShape:(val)->
			$shape = $('<g>').html val
			hash = helpers.generateHash()
			$shape.attr 'id', hash
			@model.set 'hash', hash

			if !@model.collection.parentModel.get 'isMulticolor'

				$shape.find('*').each (i, child)->
					if !@model.get 'isMulticolor'
						$child = $(child)
						if ($child.attr('fill') isnt 'none') and !($child.attr('fill').match /url/gi)
							$child.removeAttr('fill')

			$svgRef = @$svg.find "##{hash}"
			
			if $svgRef.length
				$svgRef.remove()
			@$svg.append $shape


			helpers.refreshSvg()
			@$svg = $('#svg-source')

			@model.attributes.shape = $shape.html()
			@model.set 'isShapeValid',  if $shape.children().length then true else false
			val

		setName:(val)->
			@model.set 'isNameValid',  if $.trim(val).length > 0 then true else false
			val

		initialize:(@o={})->
			@$svg = $('#svg-source')
			@$svgWrap = App.$svgWrap
			@bindModelEvents()
			@model.on 'change:name', _.bind @modelChange, @
			@model.on 'change:shape', _.bind @modelChange, @
			super
			if @model.get('shape') and (@model.collection.mode isnt 'edit')
				@setShape @model.get('shape')
			@

		modelChange:->
			@model.set 'isValid', @model.get('isNameValid') and @model.get('isShapeValid')
			App.vent.trigger 'edit-collection:change'

		render:->
			focusId = @$(':focus').attr 'id'
			super
			@stickit()
			@$("##{focusId}").focus()
			@
			
		bindModelEvents:->
			@model.on 'change:shape', @render
			@model.on 'change:isNameValid', @render
			@model.on 'change:isShapeValid', @render



		destroy:->
			@model.collection.length is 1 and @model.collection.add {}
			@model.destroy()
			App.vent.trigger 'edit-collection:change'
			


	IconEditView