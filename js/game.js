var game = new Phaser.Game(800, 600, Phaser.AUTO, '', {preload: preload, create: create, update: update});
var player = new Player(game);

function preload() {
	player.preload();
}

function create() {
	game.stage.setBackgroundColor('rgb(255,255,255)');
	player.create();
}

function update() {
	
}