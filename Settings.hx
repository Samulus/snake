/*
    Settings.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.ui.Keyboard;

class Settings {
    public static var CELL_HEIGHT = 16; // Only works for 16?
    public static var CELL_WIDTH = 16;
    public static var SCREEN_WIDTH = 400;
    public static var SCREEN_HEIGHT = 300;
    public static var MS_PER_UPDATE = 100;

    public static var Players = [

        new Player(
            "Sam", 0x00FF00,
            new KeyboardInputDevice(Keyboard.W, Keyboard.S, Keyboard.A, Keyboard.D)
        ),

        new Player(
            "Alice", 0x0000FF,
            new KeyboardInputDevice(Keyboard.UP, Keyboard.DOWN, Keyboard.LEFT, Keyboard.RIGHT)
        )

/*
        new Player(
            "Alice", 0x0000FF,
            new MouseInputDevice(),
        )
        */

    ];
}