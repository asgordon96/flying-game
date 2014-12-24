class @OncomingPlanes
	@preload: (game) ->
		game.load.image("oncoming_plane", "sprites/airplane_flipped.png")
	
	constructor: (game, player) ->
		@game = game
		@player = player
		
	setup: ->
		@planes = @game.add.group()
		@planes.enableBody = true
	
	create_plane: (x, y) -> 
		plane = @planes.create(x, y, "oncoming_plane")
		plane.body.velocity.x = -300
	
	create_level: (num_planes, x_start, x_end, y_start, y_end) ->
		for i in [1..num_planes]
			x = Math.random() * (x_end - x_start) + x_start
			y = Math.random() * (y_end - y_start) + y_start
			@create_plane(x, y)
		
	update: ->
		@game.physics.arcade.overlap(@planes, @player.sprite, (player, plane)->
			plane.body.velocity.x = 0
			player.body.velocity.y = 0
			player.alive = false
		)
		
			
		
		
		
	
	