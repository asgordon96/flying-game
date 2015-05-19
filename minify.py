import os
js_files = ["constants.js", "preloader.js", "menu.js", "level_complete.js", "levels.js", "obstacles.js", "display.js", "player.js", "main_game.js"]
os.system("> game-min.js") # clear the game-min.js file

for js in js_files:
    os.system("java -jar yuicompressor-2.4.8.jar js/%s >> game-min.js" % (js))
    print "Minified %s" % (js)