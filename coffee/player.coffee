class @Player
	constructor: (game) ->
		@game = game
		@passenger_health = 100
		@passenger_happiness = 100
		
	preload: ->
		game.load.image("player", "sprites/airplane_test.png")
	
	create: ->
		@sprite = game.add.sprite(100, 100, "player")
	
	  
	