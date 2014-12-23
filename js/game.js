var game = new Phaser.Game(800, 600, Phaser.AUTO, '', {preload: preload, create: create, update: update});
var player = new Player(game);
var health_bar = new HealthBar(game);
var clouds = new Clouds(game, player);

function preload() {
	player.preload(game);
	HealthBar.preload(game);
	Clouds.preload(game);
}

function create() {
	game.stage.setBackgroundColor('rgb(135,206,250)');
	player.create();
	health_bar.create(10, 20);
	clouds.create_cloud(300, 300);
}

function update() {
	player.update();
	clouds.update();
}