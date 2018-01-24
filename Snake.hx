/*
    Snake.hx
    Author: Samuel Vargas
*/

package ;

import flash.Lib;
import flash.events.Event;
import flash.ui.Keyboard;

class Snake {
    static private var player: Player;

    static public function main() {

        /* Setup Systems */
        Input.init(Lib.current.stage);
        World.init();

        /* Setup Player */
        player = new Player(64, 64, Settings.CELL_WIDTH, Settings.CELL_HEIGHT, Lib.current.stage);
        for (pos in player.getPositions()) {
            World.markOccupied(pos, player);
        }

        /* Spawn Random Apple */
        Apple.spawn(World.getAvailableRandomSpawn());
        World.markOccupied(Apple.getPosition(), new Apple());

        /* Start Input Loop */
        Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, input);

        /* Start Update + Render Loop */
        var timer = new haxe.Timer(Settings.MS_PER_UPDATE);
        timer.run = updateAndRender;
    }

    static public function input(event: Event):Void {

        /* Record requested player movement direction */
        if (Input.isPressed(Keyboard.S)) {
            player.move(Direction.South);
        } else if (Input.isPressed(Keyboard.W)) {
            player.move(Direction.North);
        } else if (Input.isPressed(Keyboard.A)) {
            player.move(Direction.East);
        } else if (Input.isPressed(Keyboard.D)) {
            player.move(Direction.West);
        }

    }

    static public function updateAndRender(): Void {
        player.update();
        player.render();

        /* Check if Apple collision */
        var apple = Apple.getPosition();
        var head = player.getHead();
        if (apple.x == head.x && apple.y == head.y) {
            player.consumeApple();
            World.markAvailable(Apple.getPosition());
            Apple.spawn(World.getAvailableRandomSpawn());
            World.markOccupied(Apple.getPosition(), new Apple());
        }

        Apple.render();
    }
}