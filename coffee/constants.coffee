@GAME_HEIGHT = 600
@GAME_WIDTH = 800

@INCOMING_PLANE_VELOCITY = 300 # in pixels per second
@CLOUD_VELOCITY = 75
@SHAKE_VELOCITY = 10
@SHAKE_HEIGHT = 20
@LIGHTNING_TIME = 0.2 # in seconds
@LIGHTNING_PROB = 2.0 / 60.0 

@LIGHTNING_DAMAGE = 3 # lightning damage per strike

@LEVEL1 =
    time: 30 # level length in seconds
    planes: 30 # per minute
    clouds: 40 # per minute
    f_lightning: 0.1 # fraction clouds that have lightning
    turbulence: 5 # per minute

# constants determining difficulty increasing
# when levels increase
@TIME_INCREASE = 5
@PLANES_INCREASE = 10
@CLOUDS_INCREASE = 10
@F_LIGHTNING_INCREASE = 0.01
@TURBULENCE_INCREASE = 10
