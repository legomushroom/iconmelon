define 'views/ThanxModalView', ['views/ProtoView', 'underscore', 'jquery' , 'helpers'], (ProtoView, IconModel, _, $, helpers)->
	class ThanxModalView extends ProtoView
		template: '#thanx-modal-view-template'
		className: 'modal-b'

		events:
			'click #js-close': 		'close'
			'click .js-findout': 	'findout'

		initialize:(@o={})->
			super
			@blindedClickFun = => @close(); App.$blinded.off 'click', @blindedClickFun

			@render()
			@

		render:->
			super
			@$el.hide().appendTo(document.body).fadeIn()
			App.$blinded.fadeIn('fast').css 'border': '1px solid rgba(0,0,0,.75)'
			App.$blinded.on 'click', @blindedClickFun
			@

		findout:->
			App.router.navigate '#/support-us', trigger: true
			@close()

		close:->
			@onClose?()
			App.$blinded.hide()
			@teardown()
			@$el.fadeOut('fast', => @$el.remove() )

	ThanxModalView