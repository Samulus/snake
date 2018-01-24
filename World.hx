/*
    World.hx
    Author: Samuel Vargas

    Keep track of where all the Apples and Snakes
    are in the game.
*/

package ;

class World {

    private static var cells: Map<Point, Entity>;

    public static function init() {
        World.cells = new Map<Point, Entity>();
    }

    public static function reset() {
        for (key in World.cells.keys()) {
            World.cells[key] = null;
        }
    }

    public static function markOccupied(p: Point, entity: Entity) {
        cells[p] = entity;
    }

    public static function markAvailable(p: Point) {
        cells[p] = null;
    }

    public static function isAppleHere(p: Point): Bool {
        return false;
    }

    public static function isSnakeHere(p: Point): Bool {
        return false;
    }
}