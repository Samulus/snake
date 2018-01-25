/*
    Main.hx
    Author: Samuel Vargas
*/

package ;

import flash.Lib;

class Main {

    static private var apple: Apple;
    static private var world: World;
    static private var gameTimer: haxe.Timer;

    static public function main() {
        // Setup Global Inputs
        GlobalKeyboardInput.init(Lib.current.stage);
        // GlobalMouseInput.init(Lib.current.stage);

        // Setup WorldArray
        world = new WorldArray(Settings.SCREEN_WIDTH, Settings.SCREEN_HEIGHT, Settings.CELL_WIDTH, Settings.CELL_HEIGHT);

        // Spawn Apple
        apple = new Apple(world.getAvailableRandomSpawn());
        world.add(apple.getPosition(), apple.getID());

        // Spawn Snakes for Players
        for (player in Settings.Players) {
            var spawn = world.getAvailableRandomSpawn();
            var snake = new Snake(spawn.x, spawn.y, Settings.CELL_WIDTH,
                                                    Settings.CELL_HEIGHT,
                                                    player.getColor(),
                                                    Settings.SCREEN_WIDTH,
                                                    Settings.SCREEN_HEIGHT);
            player.attachSnake(snake);
            world.add(spawn, snake.getID());
        }

        // Render but don't go anywhere
        render();

        // Wait Settings.MS_DELAY to start accepting input
        // This is so the player can see where they are on screen prior to
        // the game starting.

        haxe.Timer.delay(
            function() {
                // Start Player / Apple Update / Render Loops
                gameTimer = new haxe.Timer(Settings.MS_PER_UPDATE);
                gameTimer.run = loop;

            }, Settings.MS_DELAY);
    }

    static public function loop(): Void {
        input();
        update();
        render();
    }

    static public function input(): Void {
        for (player in Settings.Players) {
            var input = player.getInputDevice();
            input.update();
            player.move(input.getDirection());
        }
    }

    static public function update(): Void {
        for (player in Settings.Players) {
            player.update(world, apple);
        }
    }

    static public function render(): Void {
        for (player in Settings.Players) {
            player.render();
        }
        apple.render();
    }
}