class @Player
    constructor: (game) ->
        @game = game
        @passenger_health = 100
        @passenger_happiness = 100
    
    preload: (game) ->
        game.load.image("airplane_tail", "sprites/airplane_tail.png")
        game.load.image("airplane_body", "sprites/airplane_body.png")
        game.load.image("airplane_cockpit", "sprites/airplane_cockpit.png")
    
    create: (x, y)->
        @plane = @game.add.group()
        @tail = @plane.create(x, y, "airplane_tail")
        @body = @plane.create(x-6, y+22, "airplane_body")
        @cockpit = @plane.create(x+128, y+23, "airplane_cockpit")
        @game.physics.arcade.enable(@tail)
        @game.physics.arcade.enable(@body)
        @game.physics.arcade.enable(@cockpit)
    
    update: ->
        cursors = @game.input.keyboard.createCursorKeys()
        if cursors.up.isDown
        	if @tail.y <= 0
        		@stop()
        	else
        		@body.body.velocity.y = -100
        		@tail.body.velocity.y = -100
        		@cockpit.body.velocity.y = -100
        else if cursors.down.isDown
        	if @body.y + @body.height > GAME_HEIGHT
        		@stop()
        	else
        		@body.body.velocity.y = 100
        		@tail.body.velocity.y = 100
        		@cockpit.body.velocity.y = 100
        else
        	@stop()
    
    stop: ->
        @body.body.velocity.y = 0
        @tail.body.velocity.y = 0
        @cockpit.body.velocity.y = 0
