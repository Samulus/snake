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

        /* Start Loop */
        Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, loop);
    }

    static public function loop(event: Event):Void {

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

        /* Actually move */
        player.update();
        player.render();
        Apple.render();
    }
}