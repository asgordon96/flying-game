// Generated by CoffeeScript 1.8.0
(function() {
  this.Credits = (function() {
    function Credits(game) {}

    Credits.prototype.create = function() {
      var back, i, style, text, title, title_style, x, y, y_gap, y_start, _i, _ref;
      style = {
        font: "18px Arial",
        fill: "rgb(0,0,0)",
        align: "center"
      };
      x = 50;
      y_start = 100;
      y_gap = 40;
      title_style = {
        font: "48px Arial",
        fill: "rgb(0,0,0)",
        align: "center"
      };
      title = this.game.add.text(0, 0, "Credits", title_style);
      title.x = GAME_WIDTH / 2 - title.width / 2;
      title.y = y_start / 4;
      text = ["Programming: Aaron Gordon", "Artwork: Julie Smith and Aaron Gordon", "Sounds from freesound:", "Explosion_01.wav by tommccann (http://www.freesound.org/people/tommccann/)", "Thunder_close.wav by hantorio (http://www.freesound.org/people/hantorio/)", "Buttons created using http://dabuttonfactory.com/"];
      for (i = _i = 0, _ref = text.length; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        y = y_start + i * y_gap;
        this.game.add.text(x, y, text[i], style);
      }
      back = this.game.add.button(0, 0, "back_button", this.back_to_main_menu);
      back.x = GAME_WIDTH / 2 - back.width / 2;
      return back.y = GAME_HEIGHT - 150;
    };

    Credits.prototype.back_to_main_menu = function() {
      return this.game.state.start("Menu");
    };

    return Credits;

  })();

  this.HowToPlay = (function() {
    function HowToPlay(game) {}

    HowToPlay.prototype.create = function() {
      var back, i, style, text, title, title_style, x, y, y_gap, y_start, _i, _ref;
      title_style = {
        font: "48px Arial",
        fill: "rgb(0,0,0)",
        align: "center"
      };
      title = this.game.add.text(0, 0, "How to Play", title_style);
      title.x = GAME_WIDTH / 2 - title.width / 2;
      title.y = 25;
      style = {
        font: "24px Arial",
        fill: "rgb(0,0,0)",
        align: "center"
      };
      x = 50;
      y_start = 100;
      y_gap = 40;
      text = ["Use the up and down arrow keys to move the plane up and down", "Avoid colliding with incoming planes or getting struck by lightning", "Get as far as you can for the highest possible score"];
      for (i = _i = 0, _ref = text.length; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        y = y_start + i * y_gap;
        this.game.add.text(x, y, text[i], style);
      }
      back = this.game.add.button(0, 0, "back_button", this.back_to_main_menu);
      back.x = GAME_WIDTH / 2 - back.width / 2;
      return back.y = GAME_HEIGHT - 150;
    };

    HowToPlay.prototype.back_to_main_menu = function() {
      return this.game.state.start("Menu");
    };

    return HowToPlay;

  })();

}).call(this);
