/*
    Apple.hx
    Author: Samuel Vargas
*/

package ;

import flash.Lib;
import flash.display.Shape;

class Apple {
    private var position: Point;
    private var shape: Shape;

    public function new(point: Point) {
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
        shape.graphics.drawEllipse(0, 0, Settings.CELL_WIDTH,
                                         Settings.CELL_HEIGHT);
        shape.x = position.x;
        shape.y = position.y;
    }
}
