define 'collectionViews/ProtoCollectionView', ['marionette'], (M)->
	class ProtoCollectionView extends M.CompositeView
		
		initialize:(@o={})->
			@o.$el and @setElement @o.$el
			super
			@o.isRender and @render()
			@

		normalizeCollection:(collectionProto)->
			if @model
				modelAttr = for i of modelAttr = @model.toJSON()
					modelAttr[i]
				@collection = new collectionProto modelAttr
				# @model 		= @collection
				modelAttr 	= null

				@collection.parentCollection = @model.collection


	ProtoCollectionView

