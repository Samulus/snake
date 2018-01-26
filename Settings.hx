/*
    Settings.hx
    Author: Samuel Vargas
*/

package ;

import flash.ui.Keyboard;

class Settings {
    /* Visual */
    public static var CELL_HEIGHT = 16;
    public static var CELL_WIDTH = 16;
    public static var SCREEN_WIDTH = 1280;
    public static var SCREEN_HEIGHT = 720;

    /* Gameplay */
    public static var MS_PER_UPDATE = 75;
    public static var SNAKE_VELOCITIES = [
        Direction.North => new Point(0, -CELL_HEIGHT),
        Direction.South => new Point(0, CELL_HEIGHT),
        Direction.West => new Point(CELL_WIDTH, 0),
        Direction.East => new Point(-CELL_WIDTH, 0),
    ];

    /* Timing */
    public static var MS_DELAY_BEFORE_GAME = 3000; // Delay period before starting the game
    public static var MS_DEALY_GAME_OVER = 9000; // How long to display the game over screen

    /* Players */
    public static var Players = [

        new Player(
            "Green", 0x00FF00,
            new KeyboardInputDevice(Keyboard.W, Keyboard.S, Keyboard.A, Keyboard.D)
        ),

        new Player(
            "Cyan", 0x67F1FF,
            new MouseInputDevice()
        ),

        new Player(
            "Black", 0x000000,
            new CPUInputDevice()
        )

    ];
}
