class @Turbulence
	constructor: (game) ->
		@game = game
		@positive = true
		
	shake: ->
		shake_velocity = 10
		if @positive 
			if @game.camera.y == 20
				@positive = false
			else
				@game.camera.y += shake_velocity
		else
			if @game.camera.y == 0
				@positive = true
			else
				@game.camera.y -= shake_velocity
			

		
		
	