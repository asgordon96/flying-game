// Generated by CoffeeScript 1.8.0
(function() {
  this.Boot = (function() {
    function Boot(game) {}

    Boot.prototype.preload = function() {
      return HealthBar.preload(this.game);
    };

    Boot.prototype.create = function() {
      return this.state.start("Preloader");
    };

    return Boot;

  })();

  this.Preloader = (function() {
    function Preloader(game) {}

    Preloader.prototype.preload = function() {
      var back, front;
      back = this.add.sprite(GAME_WIDTH / 2, GAME_HEIGHT / 2, "health_bar_back");
      back.anchor.setTo(0.5, 0.5);
      front = this.add.sprite(GAME_WIDTH / 2, GAME_HEIGHT / 2, "health_bar_front");
      front.anchor.setTo(0, 0.5);
      front.x = GAME_WIDTH / 2 - front.width / 2;
      this.load.setPreloadSprite(front);
      Obstacles.preload(this.game);
      return Player.preload(this.game);
    };

    Preloader.prototype.create = function() {
      return this.game.state.start("Menu");
    };

    return Preloader;

  })();

}).call(this);
