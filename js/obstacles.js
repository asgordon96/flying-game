// Generated by CoffeeScript 1.8.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Obstacles = (function() {
    Obstacles.preload = function(game) {
      game.load.image("oncoming_plane_body", "sprites/airplane_flipped_body.png");
      game.load.image("oncoming_plane_tail", "sprites/airplane_flipped_tail.png");
      game.load.image("cloud", "sprites/cloud.png");
      game.load.image("storm_cloud", "sprites/storm_cloud.png");
      game.load.image("fog", "sprites/fog.png");
      game.load.image("turbulence", "sprites/wind.png");
      return game.load.image("lightning", "sprites/lightning.png");
    };

    function Obstacles(game, player, level) {
      this.game = game;
      this.player = player;
      this.level = level;
      this.create_lightning = __bind(this.create_lightning, this);
      this.create_turbulence = __bind(this.create_turbulence, this);
      this.create_storm_cloud = __bind(this.create_storm_cloud, this);
      this.create_cloud = __bind(this.create_cloud, this);
      this.create_plane = __bind(this.create_plane, this);
      this.clouds_last_overlapped = 0;
      this.turbulence_last_overlapped = 0;
      this.camera_direction_positive = true;
      this.last_shake_time = 0;
      this.level_object = new Level(this);
    }

    Obstacles.prototype.setup = function() {
      this.clouds = this.game.add.group();
      this.turbulence = this.game.add.group();
      this.planes = this.game.add.group();
      this.lightning = this.game.add.group();
      this.planes.enableBody = true;
      this.clouds.enableBody = true;
      this.turbulence.enableBody = true;
      this.lightning.enableBody = true;
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

    Obstacles.prototype.create_storm_cloud = function(x, y) {
      var cloud;
      cloud = this.clouds.create(x, y, "storm_cloud");
      cloud.scale.setTo(2.0, 2.0);
      return cloud.body.velocity.x = -CLOUD_VELOCITY;
    };

    Obstacles.prototype.create_turbulence = function(x, y) {
      var wind;
      wind = this.turbulence.create(x, y, "turbulence");
      return wind.body.velocity.x = -CLOUD_VELOCITY;
    };

    Obstacles.prototype.create_lightning = function(x, y) {
      var lightning;
      lightning = this.lightning.create(x, y, "lightning");
      return lightning.created_at = this.game.time.now;
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

    Obstacles.prototype.clouds_level = function(num_clouds, x_start, x_end, y_start, y_end, percent_storm) {
      this.create_obstacles(Math.round(num_clouds * (1 - percent_storm)), x_start, x_end, y_start, y_end, this.create_cloud);
      return this.create_obstacles(Math.round(num_clouds * percent_storm), x_start, x_end, y_start, y_end, this.create_storm_cloud);
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

    Obstacles.prototype.show_game_over = function() {
      return this.game.state.start("GameOver", false, false);
    };

    Obstacles.prototype.get_random_storm_cloud = function() {
      var cloud, random_index, storm_clouds;
      storm_clouds = (function() {
        var _i, _len, _ref, _ref1, _ref2, _results;
        _ref = this.clouds.children;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          cloud = _ref[_i];
          if (cloud.key === "storm_cloud" && (0 < (_ref1 = cloud.x) && _ref1 < 800) && (0 < (_ref2 = cloud.y) && _ref2 < 600)) {
            _results.push(cloud);
          }
        }
        return _results;
      }).call(this);
      if (storm_clouds.length > 0) {
        random_index = Math.floor(Math.random() * storm_clouds.length);
        return storm_clouds[random_index];
      }
    };

    Obstacles.prototype.update_lightning = function() {
      var bolt, lightning_cloud, _i, _len, _ref, _results;
      if (Math.random() < LIGHTNING_PROB) {
        lightning_cloud = this.get_random_storm_cloud();
        if (lightning_cloud) {
          this.create_lightning(lightning_cloud.x, lightning_cloud.y + lightning_cloud.height - 10);
        }
      }
      _ref = this.lightning.children;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        bolt = _ref[_i];
        if (bolt) {
          if ((this.game.time.now - bolt.created_at) > (LIGHTNING_TIME * 1000)) {
            _results.push(this.lightning.removeChild(bolt));
          } else {
            _results.push(void 0);
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Obstacles.prototype.offscreen_left = function(group) {
      var sprite, _i, _len, _ref;
      _ref = group.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        sprite = _ref[_i];
        if ((sprite.x + sprite.width) >= 0) {
          return false;
        }
      }
      return true;
    };

    Obstacles.prototype.none_right_of_coord = function(group, x_coord) {
      var sprite, _i, _len, _ref;
      _ref = group.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        sprite = _ref[_i];
        if (sprite.x > x_coord) {
          return false;
        }
      }
      return true;
    };

    Obstacles.prototype.level_complete = function() {
      var group, _i, _len, _ref;
      _ref = [this.clouds, this.planes, this.turbulence, this.lightning];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        group = _ref[_i];
        if (!this.offscreen_left(group)) {
          return false;
        }
      }
      return true;
    };

    Obstacles.prototype.update = function() {
      if (this.none_right_of_coord(this.planes, GAME_WIDTH + 100)) {
        this.level += 1;
        this.level_object.generate_level(this.level);
      }
      this.game.physics.arcade.overlap(this.player.plane, this.planes, (function(_this) {
        return function(player, plane) {
          player.parent.children.forEach(function(sprite) {
            return sprite.body.velocity.y = 0;
          });
          plane.body.velocity.x = 0;
          plane.other_part.body.velocity.x = 0;
          return _this.show_game_over();
        };
      })(this));
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
        this.game.camera.y = 0;
      }
      this.update_lightning();
      this.game.physics.arcade.overlap(this.player.plane, this.lightning, (function(_this) {
        return function() {
          return _this.player.decrease_health(LIGHTNING_DAMAGE / (0.2 * 60));
        };
      })(this));
      if (this.player.health <= 0) {
        return this.show_game_over();
      }
    };

    return Obstacles;

  })();

}).call(this);
