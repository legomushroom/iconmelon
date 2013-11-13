define 'views/pages/support', [ 	'views/pages/PageView' ], (PageView)->

	class Support extends PageView
		template: '#support-page-template'
		className: 'support-p'

		render:->
			super
			@$monthly 		= @$ '.js-monthly'
			@$budget 			= @$ '.js-budget'
			@$timeLeft 		= @$ '.js-time-left'
			@setCounters()
			_.defer => @addShareWidget()
			@

		setCounters:->
			$.ajax
				type: 'get'
				url: 	'/budget-counters'
				success:(data)=>
					@$budget.text data.budget
					@$monthly.text data.monthly
					timeLeft = ~~data.budget/~~data.monthly
					@$timeLeft.text ~~(if timeLeft < 0 then 0 else timeLeft)
				error:(e)-> console.error e

		addShareWidget:->
			$(document.head).append '<script type="text/javascript">var switchTo5x=true;</script><script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script><script type="text/javascript">stLight.options({publisher: "183e364f-5cd1-4e73-bfd9-939e94de67a5", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>'


	Support















