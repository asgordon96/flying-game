class @Clouds
	@preload: (game) ->
		game.load.image("cloud", "sprites/cloud.png")
	
	constructor: (game, player) ->
		@game = game
		@player = player
	
	create_cloud: (x, y) ->
		@clouds = @game.add.group()
		@clouds.enableBody = true
		cloud = @clouds.create(x, y, "cloud")
		cloud.scale.setTo(2.0, 2.0)
		cloud.body.velocity.x = -75
	
	update: ->
		@game.physics.arcade.overlap(@player.sprite, @clouds, ->
			console.log("Collision!!!!!!!!")
		)