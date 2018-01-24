/*
    Input.hx
    Author: Samuel Vargas
*/

package ;

import flash.display.Stage;
import flash.events.KeyboardEvent;

class Input {

    private static var stage: Stage;
    private static var keyStates: Map<UInt, Bool>;

    public static function init(stage) {
        keyStates = new Map<UInt, Bool>();
        Input.stage = stage;
        Input.stage.addEventListener(KeyboardEvent.KEY_DOWN, onPress);
        Input.stage.addEventListener(KeyboardEvent.KEY_UP, onRelease);
    }

    public static function isPressed(keyCode: UInt):Bool {
        return keyStates[keyCode] == true;
    }

    private static function onRelease(event: KeyboardEvent) {
        keyStates[event.keyCode] = false;
    }

    private static function onPress(event: KeyboardEvent) {
        keyStates[event.keyCode] = true;
    }
}