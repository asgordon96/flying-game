class @HealthBar 
    @preload: (game) ->
        game.load.image("health_bar_back", "sprites/health_bar_background.png")
        game.load.image("health_bar_front", "sprites/health_bar_front.png")
    
    constructor: (game) ->
        @percentage = 100
        @game = game
    
    create: (x, y) ->
        @back = @game.add.image(0, y, "health_bar_back")
        @front = @game.add.image(0, y, "health_bar_front")
        # now center around x
        @back.x = x - @back.width / 2
        @front.x = @back.x
    
    set_percentage: (percent) ->
        @percentage = percent
        @front.scale.x = percent / 100