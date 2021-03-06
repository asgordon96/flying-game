// Generated by CoffeeScript 1.8.0
(function() {
  this.HealthBar = (function() {
    HealthBar.preload = function(game) {
      game.load.image("health_bar_back", "sprites/health_bar_background.png");
      return game.load.image("health_bar_front", "sprites/health_bar_front.png");
    };

    function HealthBar(game) {
      this.percentage = 100;
      this.game = game;
    }

    HealthBar.prototype.create = function(x, y) {
      this.back = this.game.add.image(0, y, "health_bar_back");
      this.front = this.game.add.image(0, y, "health_bar_front");
      this.back.x = x - this.back.width / 2;
      this.front.x = this.back.x;
      return this.create_score(20, 20);
    };

    HealthBar.prototype.set_percentage = function(percent) {
      this.percentage = percent;
      return this.front.scale.x = percent / 100;
    };

    HealthBar.prototype.create_score = function(x, y) {
      var style;
      style = {
        font: "32px Arial",
        fill: "rgb(0, 0, 0)",
        align: "center"
      };
      return this.score_text = this.game.add.text(x, y, "Score: 0", style);
    };

    HealthBar.prototype.update_score = function(score) {
      return this.score_text.setText("Score: " + Math.floor(score));
    };

    return HealthBar;

  })();

}).call(this);
