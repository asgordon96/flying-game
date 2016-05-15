class @Menu
    constructor: (game) ->
    
    @preload_assets: (game) ->
        game.load.image("button", "sprites/button.png")
        game.load.image("credits_button", "sprites/credits_button.png")
        game.load.image("how_to_play", "sprites/how_to_play.png")
        game.load.image("back_button", "sprites/back_button.png")
        game.load.image("try_again", "sprites/try_again.png")
        game.load.image("next_level", "sprites/next_level.png")
    
    create: ->
        # create the Play Now button and center it 
        play_now = @game.add.button(0, 0, "button", @on_play_now)
        play_now.x = GAME_WIDTH / 2 - play_now.width / 2
        play_now.y = 300
        
        # create the how to play button and center it
        how_to_play = @game.add.button(0, 0, "how_to_play", @show_how_to_play)
        how_to_play.x = GAME_WIDTH / 2 - how_to_play.width / 2
        how_to_play.y = 360
        
        # create the credits button and center it
        credits = @game.add.button(0, 0, "credits_button", @show_credits)
        credits.x = GAME_WIDTH / 2 - credits.width / 2
        credits.y = 415
        
        style = {font: "100px Arial", fill: "rgb(0,0,0)", align: "center"}
        title = @game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Flying Game", style)
        title.anchor.set(0.5)
    
    on_play_now: ->
        @game.state.start("Game", true, false, 1)
    
    show_credits: ->
        @game.state.start("Credits", true, false)
        
    show_how_to_play: ->
        @game.state.start("HowToPlay", true, false)    
                      
    