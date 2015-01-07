class @Turbulence
    @preload: (game) ->
        game.load.image("turbulence", "sprites/wind.png")
    
    constructor: (game, player) ->
        @game = game
        @player = player
        @positive = true
        @last_overlapped = 0
    
    setup: ->
        @group = @game.add.group()
        @group.enableBody = true
    
    create_turbulence: (x, y) ->
        wind = @group.create(x, y, "turbulence")
        wind.body.velocity.x = -75
    
    update: ->
        @game.physics.arcade.overlap(@player.body, @group, =>
            @shake()
            @last_overlapped = @game.time.now + 100
        )

        if @game.time.now > @last_overlapped
            @stop_shake()
    
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
    
    stop_shake: ->
        @game.camera.y = 0
    
    create_level: (num_turbulence, x_start, x_end, y_start, y_end) ->
        for i in [1..num_turbulence]
        	x = Math.random() * (x_end - x_start) + x_start
        	y = Math.random() * (y_end - y_start) + y_start
        	@create_turbulence(x, y)
