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

        /*
            Initalize all valid onscreen cell locations to
            null by default. These will be used to detect
            collisions with apples and snakes colliding with
            themselves.
        */

        var y = 0;
        while (y < Settings.SCREEN_HEIGHT) {
            var x = 0;
            while (x < Settings.SCREEN_WIDTH) {
                World.cells[new Point(x, y)] = null;
                x += Settings.CELL_WIDTH;
            }
            y += Settings.CELL_HEIGHT;
        }

        for (y in 0 ... Settings.SCREEN_HEIGHT) {
            for (x in 0 ... Settings.SCREEN_WIDTH) {
            }
        }
    }

    public static function reset() {
        for (key in World.cells.keys()) {
            World.cells[key] = null;
        }
    }

    public static function getAvailableRandomSpawn() {
        // Lambda.array(World.cells.keys()) doesn't work for some reason
        var shuffledKeys = new Array<Point>();
        for (p in World.cells.keys()) {
            shuffledKeys.push(p);
        }

        Shuffle.fisherYates(shuffledKeys);
        for (spot in shuffledKeys) {
            if (World.cells[spot] == null) {
                return spot;
            }
        }

        trace("Entire board is full!");
        return null;
    }

    public static function markOccupied(p: Point, entity: Entity) {
        cells[p] = entity;
    }

    public static function markAvailable(p: Point) {
        cells[p] = null;
    }

    public static function isAppleHere(p: Point): Bool {
        var apple = World.cells[p];
        if (apple == null) {
            return false;
        }

        // TODO: Check if the type is an Apple without reflection
        var className = Type.getClassName(Apple);
        var objName = Type.getClassName(Type.getClass(apple));
        return className == objName;
    }

    public static function isSnakeHere(p: Point, entity: Entity): Bool {
        var snake = World.cells[p];
        if (snake == null) {
            return false;
        }
        return snake == entity;
    }
}