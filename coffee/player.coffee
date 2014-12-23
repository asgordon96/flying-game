class @Player
	constructor: (game) ->
		@game = game
		@passenger_health = 100
		@passenger_happiness = 100
		
	preload: ->
		game.load.image("player", "sprites/airplane_test.png")
	
	create: ->
		@sprite = game.add.sprite(100, 100, "player")
		@game.physics.arcade.enable(@sprite)
		@sprite.body.collideWorldBounds = true
	
	update: ->
		cursors = @game.input.keyboard.createCursorKeys()
		if cursors.up.isDown
			@sprite.body.velocity.y = -100
		else if cursors.down.isDown
			@sprite.body.velocity.y = 100
		else
			@sprite.body.velocity.y = 0
	
	  
	