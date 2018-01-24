/*
    Apple.hx
    Author: Samuel Vargas

    Apple spawner accepts an array of Player objects and users their
    positions to identify a random location on the map that is unoccupied by
    any snake.
*/

package ;
import flash.Lib;
import flash.display.Stage;
import flash.display.Shape;

class Apple implements Entity {
    private static var position: Point;
    private static var shape: Shape;

    public function new() {
        /* Dummy Function */
    }

    public static function spawn(point: Point) {
        position = Point.clone(point);
        if (shape == null) {
            shape = new Shape();
            Lib.current.stage.addChild(shape);
        }
    }

    public static function render() {
        shape.graphics.beginFill(0xFF0000);
        shape.graphics.drawRect(0, 0, Settings.CELL_WIDTH, Settings.CELL_HEIGHT);
        shape.x = position.x;
        shape.y = position.y;
    }

    public static function getPosition(): Point {
        return position;
    }
}