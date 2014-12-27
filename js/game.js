var game = new Phaser.Game(800, 600, Phaser.AUTO, '', {preload: preload, create: create, update: update});
var player = new Player(game);
var health_bar = new HealthBar(game);
var clouds = new Clouds(game, player);
var oncoming_planes = new OncomingPlanes(game, player)

function preload() {
	player.preload(game);
	HealthBar.preload(game);
	Clouds.preload(game);
	OncomingPlanes.preload(game);
}

function create() {
	game.stage.setBackgroundColor('rgb(135,206,250)');
	player.create(100, 100);
	clouds.setup();
	oncoming_planes.setup();
	health_bar.create(10, 20);
	clouds.create_cloud(600, 300);
	//oncoming_planes.create_level(10, 1000, 2000, 400, 0);
}

function update() {
	player.update();
	clouds.update();
	//oncoming_planes.update();
}