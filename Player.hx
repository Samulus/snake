/*
    Player.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.display.Stage;
import flash.display.Shape;

class Player {

    private var positions: Array<Point>;
    private var collisionMap: Map<Point, Bool>; // I would use a Set<Point> if Haxe had it
    private var lastTail: Point;
    private var blocks: Array<Shape>;
    private var velocity: Point;
    private var w: Int;
    private var h: Int;
    private var direction: Direction;
    private var stage: Stage;
    private var dead: Bool;

    public function new(x: Int, y: Int, w: Int, h: Int, stage: Stage) {
        // Setup positioning information
        this.positions = new Array<Point>();
        this.positions.insert(0, new Point(x, y));
        this.collisionMap = new Map<Point, Bool>();
        this.lastTail = new Point(x, y);
        this.w = w;
        this.h = h;
        this.stage = stage;

        // Setup actual blocks to be rendered
        this.blocks = new Array<Shape>();
        this.blocks.insert(0, new Shape());
        this.stage.addChild(this.blocks[0]);

        // Set Direction + Velocity
        this.direction = Direction.South;
        this.velocity = new Point(0, 1);

        // Set life
        this.dead = false;
    }

    public function move(desired: Direction) {

        if (dead) {
            return;
        }

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

        if (dead) {
            return;
        }

        // Record the new free cell that moving the snake always produces
        // TODO: I don't know if cloning objects is required using Haxe but
        //       I'm doing it anyway to avoid any nasty reference related
        //       bugs.
        lastTail = Point.clone(this.positions[this.positions.length - 1]);

        // Update the body of the snake.
        for (i in this.positions.length - 1 ... 0) {
            this.positions[i].x = this.positions[i - 1].x;
            this.positions[i].y = this.positions[i - 1].y;
        }

        // Update the head of the snake.
        this.positions[0].x += this.velocity.x;
        this.positions[0].y += this.velocity.y;

        // Check if the snake is dead
        checkIfSnakeDead();
    }

    private function checkIfSnakeDead() {
        /* TODO:
            1) Snake has collided with themselves (use collisionMap)
            2) Snake has hit the wall.
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

    public function growSnake(p: Point) {
    }

    public function getHead(): Point {
        return this.positions[0];
    }

    public function getLastTail(): Point {
        return this.lastTail;
    }
}