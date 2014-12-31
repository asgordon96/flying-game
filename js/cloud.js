// Generated by CoffeeScript 1.8.0
(function() {
  this.Clouds = (function() {
    Clouds.preload = function(game) {
      game.load.image("cloud", "sprites/cloud.png");
      return game.load.image("fog", "sprites/fog.png");
    };

    function Clouds(game, player) {
      this.game = game;
      this.player = player;
      this.last_overlapped = 0;
    }

    Clouds.prototype.setup = function() {
      this.clouds = this.game.add.group();
      return this.clouds.enableBody = true;
    };

    Clouds.prototype.create_cloud = function(x, y) {
      var cloud;
      cloud = this.clouds.create(x, y, "cloud");
      cloud.scale.setTo(2.0, 2.0);
      cloud.body.velocity.x = -75;
      this.fog = this.game.add.image(0, 0, "fog");
      this.fog.scale.setTo(this.game.world.width / 10, this.game.world.height / 10);
      this.fog.alpha = 0.8;
      return this.fog.visible = false;
    };

    Clouds.prototype.update = function() {
      this.game.physics.arcade.overlap(this.player.cockpit, this.clouds, (function(_this) {
        return function() {
          _this.fog.visible = true;
          return _this.last_overlapped = _this.game.time.now + 100;
        };
      })(this));
      if (this.game.time.now > this.last_overlapped) {
        return this.fog.visible = false;
      }
    };

    Clouds.prototype.create_level = function(num_clouds, x_start, x_end, y_start, y_end) {
      var i, x, y, _i, _results;
      _results = [];
      for (i = _i = 1; 1 <= num_clouds ? _i <= num_clouds : _i >= num_clouds; i = 1 <= num_clouds ? ++_i : --_i) {
        x = Math.random() * (x_end - x_start) + x_start;
        y = Math.random() * (y_end - y_start) + y_start;
        _results.push(this.create_cloud(x, y));
      }
      return _results;
    };

    return Clouds;

  })();

}).call(this);
