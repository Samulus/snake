/*
    Main.hx
    Author: Samuel Vargas
*/

package ;

import flash.Lib;
import flash.events.Event;
import flash.ui.Keyboard;

class Main {
    static private var apple: Apple;
    static private var world: World;

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

        // Start Player Input Listening Loop
        Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, input);

        // Start Player / Apple Update / Render Loops
        var timer = new haxe.Timer(Settings.MS_PER_UPDATE);
        timer.run = updateAndRender;
    }

    // Listen for input every frame for each player
    static public function input(event: Event): Void {
        for (player in Settings.Players) {
            var input = player.getInputDevice();
            input.update();
            player.move(input.getDirection());
        }
    }

    // Update and move all the players every Settings.MS_PER_UPDATE
    static public function updateAndRender(): Void {
        for (player in Settings.Players) {
            player.update(world, apple);
            player.render();
        }
        apple.render();
    }
}