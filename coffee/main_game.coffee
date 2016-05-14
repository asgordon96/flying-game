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
        
        levels = new Level(@obstacles)
        levels.generate_level(@level)
        
        @health_bar.create(GAME_WIDTH / 2, 20)
    
    update: ->        
        @player.update()
        @obstacles.update()
    
    restart: =>
        @game.state.start("Game", true, false, @level)

game = new Phaser.Game(800, 600, Phaser.AUTO, "game")

game.state.add("Boot", Boot)
game.state.add("Preloader", Preloader)
game.state.add("Menu", Menu)
game.state.add("Credits", Credits)
game.state.add("Game", MainGame)
game.state.add("GameOver", GameOver)

game.state.start("Boot")
        