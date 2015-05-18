class @MainGame
    constructor: (game) ->
    
    init: (level) ->
        @level = level
    
    create: ->
        @health_bar = new HealthBar(@game)
        
        @player = new Player(@game, @health_bar)
        @obstacles = new Obstacles(@game, @player, @level)
        @player.create(100, 100)
        @obstacles.setup()
        
        # @obstacles.clouds_level(25, 800, 2000, 0, 500, 0.5)
        # @obstacles.turbulence_level(25, 800, 2000, 0, 500)
        # @obstacles.planes_level(10, 2000, 10000, 0, 500)
        levels = new Level(@obstacles)
        levels.generate_level(@level)
        
        @health_bar.create(GAME_WIDTH / 2, 20)
    
    update: ->
        @player.update()
        @obstacles.update()
    
    restart: =>
        @game.state.start("Game", true, false, @level)

game = new Phaser.Game(800, 600, Phaser.AUTO, "game")

game.state.add("Preloader", Preloader)
game.state.add("Menu", Menu)
game.state.add("Game", MainGame)
game.state.add("LevelComplete", LevelComplete)
game.state.add("GameOver", GameOver)

game.state.start("Preloader")
        