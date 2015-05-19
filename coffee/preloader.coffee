class @Boot
    constructor: (game) ->
    
    preload: ->
        HealthBar.preload(@game)
    
    create: ->
        @state.start("Preloader")

class @Preloader
    constructor: (game) ->
    
    preload: ->
        back = @add.sprite(GAME_WIDTH / 2, GAME_HEIGHT / 2, "health_bar_back")
        back.anchor.setTo(0.5, 0.5)
        front = @add.sprite(GAME_WIDTH / 2, GAME_HEIGHT / 2, "health_bar_front")
        front.anchor.setTo(0, 0.5)
        front.x = GAME_WIDTH / 2 - front.width / 2
        @load.setPreloadSprite(front)
        
        Obstacles.preload(@game);
        Player.preload(@game);
    
    create: ->
        @game.state.start("Menu")
      
    