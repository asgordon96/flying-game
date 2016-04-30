class @HealthBar 
    @preload: (game) ->
        game.load.image("health_bar_back", "sprites/health_bar_background.png")
        game.load.image("health_bar_front", "sprites/health_bar_front.png")
    
    constructor: (game) ->
        @percentage = 100
        @game = game
    
    # add the health bar to the game
    create: (x, y) ->
        @back = @game.add.image(0, y, "health_bar_back")
        @front = @game.add.image(0, y, "health_bar_front")
        # now center around x
        @back.x = x - @back.width / 2
        @front.x = @back.x
        
        # now create the score text
        @create_score(20, 20)
    
    # set the percentage of the health bar
    # percent is between 0 and 100
    set_percentage: (percent) ->
        @percentage = percent
        @front.scale.x = percent / 100
    
    # health bar is also responsible for displaying the score
    create_score: (x, y) ->
        style = {font: "32px Arial", fill:"rgb(0, 0, 0)", align: "center"}
        @score_text = @game.add.text(x, y, "Score: 0", style)
        
    update_score: (score) ->
        @score_text.setText("Score: " + Math.floor(score))
        
    