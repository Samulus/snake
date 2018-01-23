/*
    Player.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.display.Stage;
import flash.display.Shape;

class Player {

    private var x: Int;
    private var y: Int;
    private var w: Int;
    private var h: Int;
    private var shape: Shape;
    private var stage: Stage;
    private var direction: Direction;

    public function new(x, y, w, h, stage) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.shape = new Shape();
        this.stage = stage;
    }

    public function move() {
    }

    public function update() {
    }

    public function render() {
        shape.graphics.beginFill(0x333333);
        shape.graphics.drawRect(this.x, this.y, this.w, this.h);
        stage.addChild(shape);
    }
}