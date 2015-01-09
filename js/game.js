var game = new Phaser.Game(800, 600, Phaser.AUTO, "game");

game.state.add("Preloader", Preloader);
game.state.add("Menu", Menu);
game.state.add("Game", MainGame);

game.state.start("Preloader");
