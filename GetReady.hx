/*
    GetReady.hx
    Author: Samuel Vargas
*/

package ;

import flash.Lib;
import flash.text.TextField;

class GetReady {
    private static var messageField: TextField;

    public static function display() {
        messageField = new TextField();
        messageField.text = "Game Will Begin In: " + Settings.MS_DELAY_BEFORE_GAME + " ms.";
        messageField.width = Settings.SCREEN_WIDTH;
        Lib.current.stage.addChild(messageField);
    }

    public static function clear() {
        Lib.current.stage.removeChild(messageField);
    }
}