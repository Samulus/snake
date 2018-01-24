/*
    Apple.hx
    Author: Samuel Vargas

    Apple spawner accepts an array of Player objects and users their
    positions to identify a random location on the map that is unoccupied by
    any snake.
*/

package ;

class Apple {

    private static var applePresent = false;

    public static function init() {
        applePresent = false;
    }

    public static function spawn(players: Array<Player>) {
    }

}
