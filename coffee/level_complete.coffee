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
    