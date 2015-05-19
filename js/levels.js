// Generated by CoffeeScript 1.8.0
(function() {
  this.Level = (function() {
    function Level(obstacles) {
      this.obstacles = obstacles;
    }

    Level.prototype.generate_level_objects = function(level_obj) {
      var num_clouds, num_planes, num_turbulence, x_end;
      num_planes = Math.round(level_obj.time / 60.0 * level_obj.planes);
      x_end = level_obj.time * INCOMING_PLANE_VELOCITY;
      this.obstacles.planes_level(num_planes, GAME_WIDTH, x_end, 0, GAME_HEIGHT - 100);
      num_clouds = Math.round(level_obj.time / 60.0 * level_obj.clouds);
      x_end = level_obj.time * CLOUD_VELOCITY;
      this.obstacles.clouds_level(num_clouds, GAME_WIDTH, x_end, 0, GAME_HEIGHT - 100, level_obj.f_lightning);
      num_turbulence = Math.round(level_obj.time / 60.0 * level_obj.turbulence);
      return this.obstacles.turbulence_level(num_turbulence, GAME_WIDTH, x_end, 0, GAME_HEIGHT - 100);
    };

    Level.prototype.generate_level = function(level) {
      var level_object, x;
      x = level - 1;
      level_object = {
        time: LEVEL1.time + x * TIME_INCREASE,
        planes: LEVEL1.planes + x * PLANES_INCREASE,
        clouds: LEVEL1.clouds + x * CLOUDS_INCREASE,
        f_lightning: LEVEL1.f_lightning + x * F_LIGHTNING_INCREASE,
        turbulence: LEVEL1.turbulence + x * TURBULENCE_INCREASE
      };
      console.log(level_object);
      return this.generate_level_objects(level_object);
    };

    return Level;

  })();

}).call(this);