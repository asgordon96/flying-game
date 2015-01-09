class @Obstacles
    @preload: (game) ->
        game.load.image("oncoming_plane_body", "sprites/airplane_flipped_body.png")
        game.load.image("oncoming_plane_tail", "sprites/airplane_flipped_tail.png")
        game.load.image("cloud", "sprites/cloud.png")
        game.load.image("fog", "sprites/fog.png")
        game.load.image("turbulence", "sprites/wind.png")
    
    constructor: (@game, @player) ->
        @clouds_last_overlapped = 0
        @turbulence_last_overlapped = 0
        @camera_direction_positive = true
        @last_shake_time = 0
        
    setup: ->
        @clouds = @game.add.group()
        @turbulence = @game.add.group()
        @planes = @game.add.group()
        @planes.enableBody = true
        @clouds.enableBody = true
        @turbulence.enableBody = true
        
        @fog = @game.add.image(0, 0, "fog")
        @fog.scale.setTo(GAME_WIDTH / 10, (GAME_HEIGHT+SHAKE_HEIGHT) / 10)
        @fog.alpha = 0.8
        @fog.visible = false
    
    create_plane: (x, y) => 
        tail = @planes.create(x, y, "oncoming_plane_tail")
        body = @planes.create(x-78, y+23, "oncoming_plane_body")
        tail.body.velocity.x = -INCOMING_PLANE_VELOCITY
        body.body.velocity.x = -INCOMING_PLANE_VELOCITY
        tail.other_part = body
        body.other_part = tail
    
    create_cloud: (x, y) =>
        cloud = @clouds.create(x, y, "cloud")
        cloud.scale.setTo(2.0, 2.0)
        cloud.body.velocity.x = -CLOUD_VELOCITY
    
    create_turbulence: (x, y) =>
        wind = @turbulence.create(x, y, "turbulence")
        wind.body.velocity.x = -CLOUD_VELOCITY
    
    create_obstacles: (num_obstacles, x_start, x_end, y_start, y_end, create_function) ->
        for i in [1..num_obstacles]
        	x = Math.random() * (x_end - x_start) + x_start
        	y = Math.random() * (y_end - y_start) + y_start
        	create_function(x, y)
    
    clouds_level: (num_clouds, x_start, x_end, y_start, y_end) ->
        @create_obstacles(num_clouds, x_start, x_end, y_start, y_end, @create_cloud)
    
    planes_level: (num_planes, x_start, x_end, y_start, y_end) ->
        @create_obstacles(num_planes, x_start, x_end, y_start, y_end, @create_plane)
    
    turbulence_level: (num_turbulence, x_start, x_end, y_start, y_end) ->
        @create_obstacles(num_turbulence, x_start, x_end, y_start, y_end, @create_turbulence)
    
    shake: ->
        if (@game.time.now - @last_shake_time) > 10
            if @camera_direction_positive 
                if @game.camera.y == SHAKE_HEIGHT
                    @camera_direction_positive = false
                else
                    @game.camera.y += SHAKE_VELOCITY
            else
                if @game.camera.y == 0
                    @camera_direction_positive = true
                else
                    @game.camera.y -= SHAKE_VELOCITY
                
        @last_shake_time = @game.time.now
    
    set_game_over_objects: (text, button) ->
        @game_over_text = text
        @button = button
    
    show_game_over: ->
        @game_over_text.visible = true
        @button.visible = true
    
    update: ->
        @game.physics.arcade.overlap(@player.plane, @planes, (player, plane) =>
            player.parent.children.forEach (sprite) ->
                sprite.body.velocity.y = 0
            
            plane.body.velocity.x = 0
            plane.other_part.body.velocity.x = 0
            @show_game_over()
        )
        
        @game.physics.arcade.overlap(@player.cockpit, @clouds, =>
        	@fog.visible = true
        	@clouds_last_overlapped = @game.time.now + 100
        )

        if @game.time.now > @clouds_last_overlapped
        	@fog.visible = false
        
        @game.physics.arcade.overlap(@player.body, @turbulence, =>
            @shake()
            @turbulence_last_overlapped = @game.time.now + 100
        )

        if @game.time.now > @turbulence_last_overlapped
            @game.camera.y = 0
        