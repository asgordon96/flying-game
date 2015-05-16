class @Menu
    constructor: (game) ->
    
    preload: ->
        @game.load.image("button", "sprites/button.png")
        @game.load.image("try_again", "sprites/try_again.png")
        @game.load.image("next_level", "sprites/next_level.png")
    
    create: ->
        @game.add.button(GAME_WIDTH / 2 - 76, 300, "button", @on_play_now)
        @game.stage.setBackgroundColor('rgb(135,206,250)')
        @game.world.setBounds(0, 0, 2000, 2000)
        
        style = {font: "100px Arial", fill: "rgb(0,0,0)", align: "center"}
        title = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Flying Game", style)
        title.anchor.set(0.5)
    
    on_play_now: ->
        @game.state.start("Game", true, false, 1)
                      
    