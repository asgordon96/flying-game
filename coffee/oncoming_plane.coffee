class @OncomingPlanes
    @preload: (game) ->
        game.load.image("oncoming_plane_body", "sprites/airplane_flipped_body.png")
        game.load.image("oncoming_plane_tail", "sprites/airplane_flipped_tail.png")
    
    constructor: (game, player) ->
        @game = game
        @player = player
    
    setup: ->
        @planes = @game.add.group()
        @planes.enableBody = true
        
    create_plane: (x, y) -> 
        tail = @planes.create(x, y, "oncoming_plane_tail")
        body = @planes.create(x-78, y+23, "oncoming_plane_body")
        tail.body.velocity.x = -300
        body.body.velocity.x = -300
        tail.other_part = body
        body.other_part = tail
        
    
    create_level: (num_planes, x_start, x_end, y_start, y_end) ->
        for i in [1..num_planes]
            x = Math.random() * (x_end - x_start) + x_start
            y = Math.random() * (y_end - y_start) + y_start
            @create_plane(x, y)
    
    stop: ->
        @planes.children.forEach((part) ->
            part.body.velocity.x = 0
        )
    
    update: ->
        @game.physics.arcade.overlap(@player.plane, @planes, (player, plane) ->
            player.parent.children.forEach (sprite) ->
                sprite.body.velocity.y = 0
            
            plane.body.velocity.x = 0
            plane.other_part.body.velocity.x = 0
        )
