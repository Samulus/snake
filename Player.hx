/*
    Player.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.display.Stage;
import flash.display.Shape;

class Player {

    private var position: Point;
    private var velocity: Point;
    private var w: Int;
    private var h: Int;
    private var shape: Shape;
    private var stage: Stage;
    private var direction: Direction;

    public function new(x: Int, y: Int, w: Int, h: Int, stage: Stage) {
        this.position = new Point(x, y);
        this.w = w;
        this.h = h;
        this.shape = new Shape();
        this.stage = stage;

        // Set Direction + Velocity
        this.direction = Direction.South;
        this.velocity = new Point(0, 1);
    }

    public function move(desired: Direction) {
        if (desired == Direction.North && direction != Direction.South) {
            this.velocity.x = 0;
            this.velocity.y = -1;
            this.direction = desired;
        }

        else if (desired == Direction.South && direction != Direction.North) {
            this.velocity.x = 0;
            this.velocity.y = 1;
            this.direction = desired;
        }

        else if (desired == Direction.East && direction != Direction.West) {
            this.velocity.x = -1;
            this.velocity.y = 0;
            this.direction = desired;
        }

        else if (desired == Direction.West && direction != Direction.East) {
            this.velocity.x = 1;
            this.velocity.y = 0;
            this.direction = desired;
        }
    }

    public function update() {
        this.position.x += this.velocity.x;
        this.position.y += this.velocity.y;
    }

    public function render() {
        shape.graphics.beginFill(0x333333);
        shape.graphics.drawRect(0, 0, this.w, this.h);
        shape.x = this.position.x;
        shape.y = this.position.y;
        stage.addChild(shape);
    }
}