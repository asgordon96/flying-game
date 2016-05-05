class @GameOver
    constructor: (game) ->
    
    # whoever is calling this state will provide us with the player's score
    init: (score) ->
        @score = score
    
    create: ->
        style = {font: "76px Arial", fill: "rgb(0,0,0)", align: "center"}
        game_over_text = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Game Over", style)
        game_over_text.anchor.set(0.5)
        
        score_style = {font: "48px Arial", fill: "rgb(0, 0, 0)", align: "center"}
        score_text = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2, "Your Score: " + @score, score_style)
        score_text.anchor.set(0.5)
        
        play_again = @game.add.button(GAME_WIDTH / 2 - 76, 350, "try_again", =>
            @game.state.start("Game", true, false, 1)
        )
