class @Level
    constructor: (obstacles) ->
        @obstacles = obstacles
    
    generate_level_objects: (level_obj) ->
        # create oncoming planes
        num_planes = Math.round(level_obj.time / 60.0 * level_obj.planes)
        x_end = level_obj.time * INCOMING_PLANE_VELOCITY
        @obstacles.planes_level(num_planes, GAME_WIDTH, x_end, 0, GAME_HEIGHT - 100)
        
        # now create clouds
        num_clouds = Math.round(level_obj.time / 60.0 * level_obj.clouds)
        x_end = level_obj.time * CLOUD_VELOCITY
        @obstacles.clouds_level(num_clouds, GAME_WIDTH, x_end, 0, GAME_HEIGHT- 100, level_obj.f_lightning)
        
        # now create turbulence
        num_turbulence = Math.round(level_obj.time / 60.0 * level_obj.turbulence)
        # x_end is the same as for clouds, since turbulence has same v as clouds
        @obstacles.turbulence_level(num_turbulence, GAME_WIDTH, x_end, 0, GAME_HEIGHT - 100)
    
    generate_level: (level) ->
        x = level - 1
        level_object =
            time: LEVEL1.time + x * TIME_INCREASE
            planes: LEVEL1.planes + x * PLANES_INCREASE
            clouds: LEVEL1.clouds + x * CLOUDS_INCREASE
            f_lightning: LEVEL1.f_lightning + x * F_LIGHTNING_INCREASE
            turbulence: LEVEL1.turbulence + x * TURBULENCE_INCREASE
        
        @generate_level_objects(level_object)
    