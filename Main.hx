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
    static private var snake: Snake;
    static private var world: World;

    static public function main() {

        /* Setup Systems */
        Input.init(Lib.current.stage);
        world = new WorldArray(Settings.SCREEN_WIDTH, Settings.SCREEN_HEIGHT, Settings.CELL_WIDTH, Settings.CELL_HEIGHT);

        /* Setup Player */
        snake = new Snake(16, 16, Settings.CELL_WIDTH,
                                    Settings.CELL_HEIGHT,
                                    Settings.SCREEN_WIDTH,
                                    Settings.SCREEN_HEIGHT, Lib.current.stage);

        for (pos in snake.getPositions()) {
            world.add(pos, snake.getID()); // Add the snake + all their body segments to the worldmap
        }

        /* Spawn Apple */
        apple = new Apple(world.getAvailableRandomSpawn());
        world.add(apple.getPosition(), apple.getID());


        /* Start Input Loop */
        Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, input);

        /* Start Update + Render Loop */
        var timer = new haxe.Timer(Settings.MS_PER_UPDATE);
        timer.run = updateAndRender;
    }

    static public function input(event: Event):Void {

        /* Record requested snake movement direction */
        if (Input.isPressed(Keyboard.S)) {
            snake.move(Direction.South);
        } else if (Input.isPressed(Keyboard.W)) {
            snake.move(Direction.North);
        } else if (Input.isPressed(Keyboard.A)) {
            snake.move(Direction.East);
        } else if (Input.isPressed(Keyboard.D)) {
            snake.move(Direction.West);
        }

    }

    static public function updateAndRender(): Void {
        snake.update(world, apple);
        snake.render();
        apple.render();
    }
}