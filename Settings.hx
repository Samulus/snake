/*
    Settings.hx
    Author: Samuel Vargas
*/

package ;
import flash.ui.Keyboard;

class Settings {
    public static var CELL_HEIGHT = 16; // Only works for 16?
    public static var CELL_WIDTH = 16;
    public static var SCREEN_WIDTH = 1280;
    public static var SCREEN_HEIGHT = 720;
    public static var MS_PER_UPDATE = 75;
    public static var MS_DELAY_BEFORE_GAME = 1000; // Delay period before starting the game
    public static var MS_DEALY_GAME_OVER = 5000; // How long to display the game over screen

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