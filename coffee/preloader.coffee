class @Preloader
    constructor: (game) ->
    
    preload: ->
        HealthBar.preload(@game);
        Obstacles.preload(@game);
        Player.preload(@game);
    
    create: ->
        @game.state.start("Menu")
      
    