class @LevelComplete
    constructor: (game) ->
    
    init: (level_number) ->
        @level_number = level_number
    
    create: ->
        style = {font: "100px Arial", fill: "rgb(0,0,0)", align: "center"}
        text = "Level #{ @level_number } Complete"
        complete = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, text, style)
        complete.anchor.set(0.5)
        next_level = @game.add.button(0, 300, "next_level", @begin_next_level)
        next_level.x = GAME_WIDTH / 2 - next_level.width / 2
    
    begin_next_level: =>
        @game.state.start("Game", true, false, @level_number + 1)


class @GameOver
    constructor: (game) ->
    
    create: ->
        style = {font: "76px Arial", fill: "rgb(0,0,0)", align: "center"}
        game_over_text = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Game Over", style)
        game_over_text.anchor.set(0.5)
        play_again = @game.add.button(GAME_WIDTH / 2 - 76, 300, "try_again", =>
            @game.state.start("Game", true, false, 1)
        )
