class @Clouds
    @preload: (game) ->
        game.load.image("cloud", "sprites/cloud.png")
        game.load.image("fog", "sprites/fog.png")

    constructor: (game, player) ->
        @game = game
        @player = player
        @last_overlapped = 0

    setup: ->
        @clouds = @game.add.group()
        @clouds.enableBody = true

    create_cloud: (x, y) ->
        cloud = @clouds.create(x, y, "cloud")
        cloud.scale.setTo(2.0, 2.0)
        cloud.body.velocity.x = -75

        @fog = @game.add.image(0, 0, "fog")
        @fog.scale.setTo(@game.world.width / 10, @game.world.height / 10)
        @fog.alpha = 0.8
        @fog.visible = false

    update: ->
        @game.physics.arcade.overlap(@player.cockpit, @clouds, =>
        	@fog.visible = true
        	@last_overlapped = @game.time.now + 100
        )

        if @game.time.now > @last_overlapped
        	@fog.visible = false

    create_level: (num_clouds, x_start, x_end, y_start, y_end) ->
        for i in [1..num_clouds]
        	x = Math.random() * (x_end - x_start) + x_start
        	y = Math.random() * (y_end - y_start) + y_start
        	@create_cloud(x, y)
