class @MainGame
    constructor: (game) ->
    
    create: ->
        @player = new Player(@game)
        @obstacles = new Obstacles(@game, @player)
        @player.create(100, 100)
        @obstacles.setup()
        
        @obstacles.clouds_level(25, 800, 2000, 0, 500)
        @obstacles.turbulence_level(25, 800, 2000, 0, 500)
        @obstacles.planes_level(10, 2000, 10000, 0, 500)
        
        style = {font: "100px Arial", fill: "rgb(0,0,0)", align: "center"}
        @game_over_text = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Game Over", style)
        @play_again = @game.add.button(GAME_WIDTH / 2 - 76, 300, "try_again", @restart)
        @game_over_text.visible = false
        @play_again.visible = false
        @game_over_text.anchor.set(0.5)
        @obstacles.set_game_over_objects(@game_over_text, @play_again)
    
    update: ->
        @player.update()
        @obstacles.update()
    
    restart: ->
        @game.state.start("Game")

game = new Phaser.Game(800, 600, Phaser.AUTO, "game")

game.state.add("Preloader", Preloader)
game.state.add("Menu", Menu)
game.state.add("Game", MainGame)

game.state.start("Preloader")
        