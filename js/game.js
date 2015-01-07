var game = new Phaser.Game(800, 600, Phaser.AUTO, '', {preload: preload, create: create, update: update});
var player = new Player(game);
var health_bar = new HealthBar(game);
var obstacles = new Obstacles(game, player);

function preload() {
    player.preload(game);
    HealthBar.preload(game);
    Obstacles.preload(game);
}

function create() {
    game.stage.setBackgroundColor('rgb(135,206,250)');
    game.world.setBounds(0, 0, 2000, 2000);

    player.create(100, 100);
    obstacles.setup();
    health_bar.create(10, 20);
    
    obstacles.clouds_level(25, 300, 2000, 0, 500);
    obstacles.turbulence_level(25, 300, 2000, 0, 500);
    //obstacles.planes_level(20, 1000, 2000, 400, 0);
}

function update() {
    player.update();
    obstacles.update();
    //clouds.update();
    //oncoming_planes.update();
    //turbulence.update();
}