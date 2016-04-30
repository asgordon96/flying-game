// Generated by CoffeeScript 1.8.0
(function() {
  this.Player = (function() {
    Player.preload = function(game) {
      game.load.image("airplane_tail", "sprites/airplane_tail.png");
      game.load.image("airplane_body", "sprites/airplane_body.png");
      return game.load.image("airplane_cockpit", "sprites/airplane_cockpit.png");
    };

    function Player(game, health_bar) {
      this.game = game;
      this.health = 100;
      this.score = 0;
      this.health_bar = health_bar;
    }

    Player.prototype.create = function(x, y) {
      this.plane = this.game.add.group();
      this.tail = this.plane.create(x, y, "airplane_tail");
      this.body = this.plane.create(x - 6, y + 22, "airplane_body");
      this.cockpit = this.plane.create(x + 128, y + 23, "airplane_cockpit");
      this.game.physics.arcade.enable(this.tail);
      this.game.physics.arcade.enable(this.body);
      return this.game.physics.arcade.enable(this.cockpit);
    };

    Player.prototype.update = function() {
      var cursors, dt;
      cursors = this.game.input.keyboard.createCursorKeys();
      if (cursors.up.isDown) {
        if (this.tail.y <= 0) {
          this.stop();
        } else {
          this.body.body.velocity.y = -100;
          this.tail.body.velocity.y = -100;
          this.cockpit.body.velocity.y = -100;
        }
      } else if (cursors.down.isDown) {
        if (this.body.y + this.body.height > GAME_HEIGHT) {
          this.stop();
        } else {
          this.body.body.velocity.y = 100;
          this.tail.body.velocity.y = 100;
          this.cockpit.body.velocity.y = 100;
        }
      } else {
        this.stop();
      }
      dt = this.game.time.physicsElapsed;
      this.score = this.score + SCORE_PER_SECOND * dt;
      return this.health_bar.update_score(this.score);
    };

    Player.prototype.stop = function() {
      this.body.body.velocity.y = 0;
      this.tail.body.velocity.y = 0;
      return this.cockpit.body.velocity.y = 0;
    };

    Player.prototype.decrease_health = function(amount) {
      this.health -= amount;
      if (this.health < 0) {
        this.health = 0;
      }
      return this.health_bar.set_percentage(this.health);
    };

    return Player;

  })();

}).call(this);
