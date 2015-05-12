class @Preloader
    constructor: (game) ->
    
    preload: ->
        HealthBar.preload(@game);
        Obstacles.preload(@game);
        Player.preload(@game);
        HealthBar.preload(@game);
    
    create: ->
        @game.state.start("Menu")
      
    