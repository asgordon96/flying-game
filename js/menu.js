// Generated by CoffeeScript 1.8.0
(function() {
  this.Menu = (function() {
    function Menu(game) {}

    Menu.preload_assets = function(game) {
      game.load.image("button", "sprites/button.png");
      game.load.image("credits_button", "sprites/credits_button.png");
      game.load.image("back_button", "sprites/back_button.png");
      game.load.image("try_again", "sprites/try_again.png");
      return game.load.image("next_level", "sprites/next_level.png");
    };

    Menu.prototype.create = function() {
      var credits, play_now, style, title;
      play_now = this.game.add.button(0, 0, "button", this.on_play_now);
      play_now.x = GAME_WIDTH / 2 - play_now.width / 2;
      play_now.y = 300;
      credits = this.game.add.button(0, 0, "credits_button", this.show_credits);
      credits.x = GAME_WIDTH / 2 - credits.width / 2;
      credits.y = 360;
      style = {
        font: "100px Arial",
        fill: "rgb(0,0,0)",
        align: "center"
      };
      title = this.game.add.text(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100, "Flying Game", style);
      return title.anchor.set(0.5);
    };

    Menu.prototype.on_play_now = function() {
      return this.game.state.start("Game", true, false, 1);
    };

    Menu.prototype.show_credits = function() {
      return this.game.state.start("Credits", true, false);
    };

    return Menu;

  })();

}).call(this);
