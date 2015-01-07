// Generated by CoffeeScript 1.8.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Obstacles = (function() {
    Obstacles.preload = function(game) {
      game.load.image("oncoming_plane_body", "sprites/airplane_flipped_body.png");
      game.load.image("oncoming_plane_tail", "sprites/airplane_flipped_tail.png");
      game.load.image("cloud", "sprites/cloud.png");
      game.load.image("fog", "sprites/fog.png");
      return game.load.image("turbulence", "sprites/wind.png");
    };

    function Obstacles(game, player) {
      this.game = game;
      this.player = player;
      this.create_turbulence = __bind(this.create_turbulence, this);
      this.create_cloud = __bind(this.create_cloud, this);
      this.create_plane = __bind(this.create_plane, this);
      this.clouds_last_overlapped = 0;
      this.turbulence_last_overlapped = 0;
      this.camera_direction_positive = true;
      this.last_shake_time = 0;
    }

    Obstacles.prototype.setup = function() {
      this.clouds = this.game.add.group();
      this.turbulence = this.game.add.group();
      this.planes = this.game.add.group();
      this.planes.enableBody = true;
      this.clouds.enableBody = true;
      this.turbulence.enableBody = true;
      this.fog = this.game.add.image(0, 0, "fog");
      this.fog.scale.setTo(GAME_WIDTH / 10, (GAME_HEIGHT + SHAKE_HEIGHT) / 10);
      this.fog.alpha = 0.8;
      return this.fog.visible = false;
    };

    Obstacles.prototype.create_plane = function(x, y) {
      var body, tail;
      tail = this.planes.create(x, y, "oncoming_plane_tail");
      body = this.planes.create(x - 78, y + 23, "oncoming_plane_body");
      tail.body.velocity.x = -INCOMING_PLANE_VELOCITY;
      body.body.velocity.x = -INCOMING_PLANE_VELOCITY;
      tail.other_part = body;
      return body.other_part = tail;
    };

    Obstacles.prototype.create_cloud = function(x, y) {
      var cloud;
      cloud = this.clouds.create(x, y, "cloud");
      cloud.scale.setTo(2.0, 2.0);
      return cloud.body.velocity.x = -CLOUD_VELOCITY;
    };

    Obstacles.prototype.create_turbulence = function(x, y) {
      var wind;
      wind = this.turbulence.create(x, y, "turbulence");
      return wind.body.velocity.x = -CLOUD_VELOCITY;
    };

    Obstacles.prototype.create_obstacles = function(num_obstacles, x_start, x_end, y_start, y_end, create_function) {
      var i, x, y, _i, _results;
      _results = [];
      for (i = _i = 1; 1 <= num_obstacles ? _i <= num_obstacles : _i >= num_obstacles; i = 1 <= num_obstacles ? ++_i : --_i) {
        x = Math.random() * (x_end - x_start) + x_start;
        y = Math.random() * (y_end - y_start) + y_start;
        _results.push(create_function(x, y));
      }
      return _results;
    };

    Obstacles.prototype.clouds_level = function(num_clouds, x_start, x_end, y_start, y_end) {
      return this.create_obstacles(num_clouds, x_start, x_end, y_start, y_end, this.create_cloud);
    };

    Obstacles.prototype.planes_level = function(num_planes, x_start, x_end, y_start, y_end) {
      return this.create_obstacles(num_planes, x_start, x_end, y_start, y_end, this.create_plane);
    };

    Obstacles.prototype.turbulence_level = function(num_turbulence, x_start, x_end, y_start, y_end) {
      return this.create_obstacles(num_turbulence, x_start, x_end, y_start, y_end, this.create_turbulence);
    };

    Obstacles.prototype.shake = function() {
      if ((this.game.time.now - this.last_shake_time) > 10) {
        if (this.camera_direction_positive) {
          if (this.game.camera.y === SHAKE_HEIGHT) {
            this.camera_direction_positive = false;
          } else {
            this.game.camera.y += SHAKE_VELOCITY;
          }
        } else {
          if (this.game.camera.y === 0) {
            this.camera_direction_positive = true;
          } else {
            this.game.camera.y -= SHAKE_VELOCITY;
          }
        }
      }
      return this.last_shake_time = this.game.time.now;
    };

    Obstacles.prototype.update = function() {
      this.game.physics.arcade.overlap(this.player.plane, this.planes, function(player, plane) {
        player.parent.children.forEach(function(sprite) {
          return sprite.body.velocity.y = 0;
        });
        plane.body.velocity.x = 0;
        return plane.other_part.body.velocity.x = 0;
      });
      this.game.physics.arcade.overlap(this.player.cockpit, this.clouds, (function(_this) {
        return function() {
          _this.fog.visible = true;
          return _this.clouds_last_overlapped = _this.game.time.now + 100;
        };
      })(this));
      if (this.game.time.now > this.clouds_last_overlapped) {
        this.fog.visible = false;
      }
      this.game.physics.arcade.overlap(this.player.body, this.turbulence, (function(_this) {
        return function() {
          _this.shake();
          return _this.turbulence_last_overlapped = _this.game.time.now + 100;
        };
      })(this));
      if (this.game.time.now > this.turbulence_last_overlapped) {
        return this.game.camera.y = 0;
      }
    };

    return Obstacles;

  })();

}).call(this);
