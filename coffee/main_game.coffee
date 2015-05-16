class @MainGame
    constructor: (game) ->
    
    init: (level) ->
        @level = level
    
    create: ->
        console.log("Starting Level #{ @level }")
        @health_bar = new HealthBar(@game)
        
        @player = new Player(@game, @health_bar)
        @obstacles = new Obstacles(@game, @player, @level)
        @player.create(100, 100)
        @obstacles.setup()
        
        @obstacles.clouds_level(25, 800, 2000, 0, 500, 0.5)
        @obstacles.turbulence_level(25, 800, 2000, 0, 500)
        @obstacles.planes_level(10, 2000, 10000, 0, 500)
        
        @health_bar.create(GAME_WIDTH / 2, 20)
        
        style = {font: "76px Arial", fill: "rgb(0,0,0)", align: "center"}
        @game_over_text = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Game Over", style)
        @play_again = @game.add.button(GAME_WIDTH / 2 - 76, 300, "try_again", @restart)

        @game_over_text.visible = false
        @play_again.visible = false
        @game_over_text.anchor.set(0.5)
        @obstacles.set_game_over_objects(@game_over_text, @play_again)
    
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

game.state.start("Preloader")
        