// Generated by CoffeeScript 1.8.0
(function() {
  this.Preloader = (function() {
    function Preloader(game) {}

    Preloader.prototype.preload = function() {
      HealthBar.preload(this.game);
      Obstacles.preload(this.game);
      return Player.preload(this.game);
    };

    Preloader.prototype.create = function() {
      return this.game.state.start("Menu");
    };

    return Preloader;

  })();

}).call(this);