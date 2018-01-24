/*
    Player.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.display.Stage;
import flash.display.Shape;

class Player extends Entity {

    private var positions: Array<Point>;
    private var lastTail: Point;
    private var blocks: Array<Shape>;
    private var velocity: Point;
    private var w: Int;
    private var h: Int;
    private var direction: Direction;
    private var stage: Stage;

    // States
    private var dead: Bool;
    private var ateApple: Bool;

    public function new(x: Int, y: Int, w: Int, h: Int, stage: Stage) {
        super();

        // Setup positioning information
        this.positions = new Array<Point>();
        this.positions.push(new Point(x, y));

        this.lastTail = new Point(x, y);
        this.w = w;
        this.h = h;
        this.stage = stage;

        // Setup actual blocks to be rendered
        this.blocks = new Array<Shape>();
        this.blocks.push(new Shape());
        this.stage.addChild(this.blocks[0]);

        // Set Direction + Velocity
        this.direction = Direction.South;
        this.velocity = new Point(0, this.h);

        // Set states
        this.dead = false;
        this.ateApple = false;
    }

    public function move(desired: Direction) {

        if (dead) {
            return;
        }

        if (desired == Direction.North && direction != Direction.South) {
            this.velocity.x = 0;
            this.velocity.y = -1 * this.h;
            this.direction = desired;
        }

        else if (desired == Direction.South && direction != Direction.North) {
            this.velocity.x = 0;
            this.velocity.y = 1 * this.h;
            this.direction = desired;
        }

        else if (desired == Direction.East && direction != Direction.West) {
            this.velocity.x = -1 * this.w;
            this.velocity.y = 0;
            this.direction = desired;
        }

        else if (desired == Direction.West && direction != Direction.East) {
            this.velocity.x = 1 * this.w;
            this.velocity.y = 0;
            this.direction = desired;
        }
    }

    public function update() {

        if (dead) {
            return;
        }

        // Record the new free cell that moving the snake always produces
        // TODO: I don't know if cloning objects is required using Haxe but
        //       I'm doing it anyway to avoid any nasty reference related
        //       bugs.
        lastTail = Point.clone(this.positions[this.positions.length - 1]);

        // Update the body of the snake.
        var i=this.positions.length - 1;
        while (i > 0) {
            this.positions[i].x = this.positions[i - 1].x;
            this.positions[i].y = this.positions[i - 1].y;
            --i;
        }

        // Update the head of the snake.
        this.positions[0].x += this.velocity.x;
        this.positions[0].y += this.velocity.y;

        /* Check if the snake is dead */

        // 1) Snake has collided with itself (ignore the head)
        /*
        for (i in 1 ... this.positions.length) {
            if (World.isSnakeHere(this.positions[i], this)) {
                trace("SNAKE HAS DIED");
                dead = true;
                return;
            }
        }

        // 2) TODO: Snake is out of bounds.

        // Grow snake if needed
        if (this.ateApple) {
            this.positions.push(Point.clone(lastTail));
            this.blocks.push(new Shape());
            this.stage.addChild(this.blocks[this.blocks.length - 1]);
            this.ateApple = false;
        }

        // Record in the map where the head is, mark lastTail as available
        //World.markAvailable(Point.clone(lastTail));
        //World.markOccupied(Point.clone(this.positions[0]), this);
        */

    }

    public function render() {
        if (dead) {
            return;
        }

        for (i in 0 ... this.blocks.length) {
            this.blocks[i].graphics.beginFill(0x333333);
            this.blocks[i].graphics.drawRect(0, 0, this.w, this.h);
            this.blocks[i].x = this.positions[i].x;
            this.blocks[i].y = this.positions[i].y;
        }
    }

    public function consumeApple() {
        this.ateApple = true;
    }

    public function getPositions() {
        return this.positions;
    }

    public function getHead(): Point {
        return this.positions[0];
    }

    public function getLastTail(): Point {
        return this.lastTail;
    }
}