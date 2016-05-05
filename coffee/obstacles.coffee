class @Obstacles
    @preload: (game) ->
        game.load.image("oncoming_plane_body", "sprites/airplane_flipped_body.png")
        game.load.image("oncoming_plane_tail", "sprites/airplane_flipped_tail.png")
        game.load.image("cloud", "sprites/cloud.png")
        game.load.image("storm_cloud", "sprites/storm_cloud.png")
        game.load.image("fog", "sprites/fog.png")
        game.load.image("turbulence", "sprites/wind.png")
        game.load.image("lightning", "sprites/lightning.png")
    
    constructor: (@game, @player, @level) ->
        @clouds_last_overlapped = 0
        @turbulence_last_overlapped = 0
        @camera_direction_positive = true
        @last_shake_time = 0
        @level_object = new Level(this)
        
    setup: ->
        @clouds = @game.add.group()
        @turbulence = @game.add.group()
        @planes = @game.add.group()
        @lightning = @game.add.group()
        
        @planes.enableBody = true
        @clouds.enableBody = true
        @turbulence.enableBody = true
        @lightning.enableBody = true
        
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
        
    create_storm_cloud: (x, y) =>
        cloud = @clouds.create(x, y, "storm_cloud")
        cloud.scale.setTo(2.0, 2.0)
        cloud.body.velocity.x = -CLOUD_VELOCITY
    
    create_turbulence: (x, y) =>
        wind = @turbulence.create(x, y, "turbulence")
        wind.body.velocity.x = -CLOUD_VELOCITY
    
    create_lightning: (x, y) =>
        lightning = @lightning.create(x, y, "lightning")
        lightning.created_at = @game.time.now
    
    create_obstacles: (num_obstacles, x_start, x_end, y_start, y_end, create_function) ->
        for i in [1..num_obstacles]
        	x = Math.random() * (x_end - x_start) + x_start
        	y = Math.random() * (y_end - y_start) + y_start
        	create_function(x, y)
    
    clouds_level: (num_clouds, x_start, x_end, y_start, y_end, percent_storm) ->
        @create_obstacles(Math.round(num_clouds * (1-percent_storm)), x_start, x_end, y_start, y_end, @create_cloud)
        @create_obstacles(Math.round(num_clouds * percent_storm), x_start, x_end, y_start, y_end, @create_storm_cloud)
    
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
    
    show_game_over: ->
        @game.state.start("GameOver", false, false, Math.floor(@player.score))
    
    get_random_storm_cloud: ->
        storm_clouds = (cloud for cloud in @clouds.children when cloud.key == "storm_cloud" and 0 < cloud.x < 800 and 0 < cloud.y < 600)
        if storm_clouds.length > 0
            random_index = Math.floor(Math.random() * storm_clouds.length)
            return storm_clouds[random_index]
    
    update_lightning: ->
        if (Math.random() < LIGHTNING_PROB)
            lightning_cloud = @get_random_storm_cloud()
            if (lightning_cloud)
                @create_lightning(lightning_cloud.x, lightning_cloud.y+lightning_cloud.height-10)
        
        for bolt in @lightning.children
            if bolt
                if (@game.time.now - bolt.created_at) > (LIGHTNING_TIME * 1000)
                    @lightning.removeChild(bolt)
    
    # checks to see if ALL of a group's sprite are offscreen left
    offscreen_left: (group) ->
        for sprite in group.children
            if (sprite.x + sprite.width) >= 0
                return false
        
        return true
    
    # returns true if there is no object from the group that is offscreen right
    none_right_of_coord: (group, x_coord) ->
        for sprite in group.children
            if (sprite.x > x_coord)
                return false 
        
        # didn't find any offscreen right, since we haven't returned false yet
        return true
    
    level_complete: ->
        for group in [@clouds, @planes, @turbulence, @lightning]
            if not @offscreen_left(group)
                return false
                
        return true
    
    update: ->
        # when there are no more planes coming from the right
        # generate the objects for the new level
        if (@none_right_of_coord(@planes, GAME_WIDTH + 100))
            @level += 1
            @level_object.generate_level(@level)
        
        # collision detection with incoming planes
        @game.physics.arcade.overlap(@player.plane, @planes, (player, plane) =>
            player.parent.children.forEach (sprite) ->
                sprite.body.velocity.y = 0
            
            plane.body.velocity.x = 0
            plane.other_part.body.velocity.x = 0
            
            # if the player hits the oncoming player, they lose
            @show_game_over()
        )
        
        # show the fog if the cockpit is in the clouds
        @game.physics.arcade.overlap(@player.cockpit, @clouds, =>
        	@fog.visible = true
        	@clouds_last_overlapped = @game.time.now + 100
        )

        if @game.time.now > @clouds_last_overlapped
        	@fog.visible = false
        
        # shake the screen if the player is on an area of turbulence
        @game.physics.arcade.overlap(@player.body, @turbulence, =>
            @shake()
            @turbulence_last_overlapped = @game.time.now + 100
        )

        if @game.time.now > @turbulence_last_overlapped
            @game.camera.y = 0
        
        @update_lightning()
        
        # decrease player health when struck by lightning
        @game.physics.arcade.overlap(@player.plane, @lightning, =>
            @player.decrease_health(LIGHTNING_DAMAGE / (0.2 * 60))
        )
        
        # if player health is at 0, show game over screen
        if @player.health <= 0
            @player.stop()
            @show_game_over()
        