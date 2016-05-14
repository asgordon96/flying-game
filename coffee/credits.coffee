# a class for the game state for the credits screen
class @Credits
    constructor: (game) ->
    
    create: ->
        # setup the font style and starting x and y for the main credits text
        style = {font: "18px Arial", fill: "rgb(0,0,0)", align: "center"}
        x = 50
        y_start = 100
        y_gap = 40
        
        # create the big title that says "Credits"
        title_style = {font: "48px Arial", fill: "rgb(0,0,0)", align:"center"}
        title = @game.add.text(0, 0, "Credits", title_style)
        title.x = GAME_WIDTH / 2 - title.width / 2
        title.y = y_start / 4
        
        text = ["Programming: Aaron Gordon", "Artwork: Julie Smith and Aaron Gordon", "Sounds from freesound:", 
                "Explosion_01.wav by tommccann (http://www.freesound.org/people/tommccann/)", 
                "Thunder_close.wav by hantorio (http://www.freesound.org/people/hantorio/)",
                "Buttons created using http://dabuttonfactory.com/"]
        
        # draw text on the screen, left aligned, and with even height spacing
        for i in [0..text.length]
            y = y_start + i * y_gap
            @game.add.text(x, y, text[i], style)
        
        # add the "Back to Main Menu" button
        back = @game.add.button(0, 0, "back_button", @back_to_main_menu)
        back.x = GAME_WIDTH / 2 - back.width / 2
        back.y = GAME_HEIGHT - 150
    
    back_to_main_menu: ->
        @game.state.start("Menu")
        