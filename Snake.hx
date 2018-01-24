/*
    Snake.hx
    Author: Samuel Vargas
*/

import flash.Lib;
import flash.events.Event;

class Snake {
    static public function main() {
        Input.init(Lib.current.stage);
        Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, loop);
    }

    static public function loop(event: Event):Void {
    }
}