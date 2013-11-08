define 'views/pages/support', [ 	'views/pages/PageView' ], (PageView)->

	class Support extends PageView
		template: '#support-page-template'
		className: 'support-p'

		render:->
			super
			@$el.addClass 'animated fadeInDown'
			@$monthly 		= @$ '.js-monthly'
			@$budget 			= @$ '.js-budget'
			@$timeLeft 		= @$ '.js-time-left'
			@setCounters()
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


	Support















