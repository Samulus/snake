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
        /* Setup Player */
        player = new Player(32, 32, 16, 16, Lib.current.stage);

        /* Setup Systems */
        Input.init(Lib.current.stage);

        /* Start Loop */
        Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, loop);
    }

    static public function loop(event: Event):Void {

        if (Input.isPressed(Keyboard.S)) {
            player.move(Direction.South);
        } else if (Input.isPressed(Keyboard.W)) {
            player.move(Direction.North);
        } else if (Input.isPressed(Keyboard.A)) {
            player.move(Direction.East);
        } else if (Input.isPressed(Keyboard.D)) {
            player.move(Direction.West);
        }

        player.update();
        player.render();
    }
}