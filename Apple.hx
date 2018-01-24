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

class Apple extends Entity {
    private var position: Point;
    private var shape: Shape;

    public function new(point: Point) {
        super();
        shape = new Shape();
        this.position = point;
        Lib.current.stage.addChild(shape);
    }

    public function getPosition(): Point {
        return this.position;
    }

    public function setPosition(point: Point) {
        this.position = point;
    }

    public function render() {
        shape.graphics.beginFill(0xFF0000);
        shape.graphics.drawRect(0, 0, Settings.CELL_WIDTH, Settings.CELL_HEIGHT);
        shape.x = position.x;
        shape.y = position.y;
    }
}