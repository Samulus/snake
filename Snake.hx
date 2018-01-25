/*
    Snake.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.display.Shape;

class Snake extends Entity {

    // Positional Information
    private var positions: Array<Point>;
    private var lastTail: Point;
    private var velocityMap: Map<Direction, Point>;
    private var velocity: Point;
    private var direction: Direction; // Human readable velocity

    // Rendering Info
    private var cellWidth: UInt;
    private var cellHeight: UInt;
    private var blocks: Array<Shape>;
    private var color: UInt;

    // States
    private var dead: Bool;
    private var ateApple: Bool;

    public function new(head: Point, direction: Direction,
                        velocityMap: Map<Direction, Point>,
                        color: UInt, cellWidth: UInt, cellHeight: UInt) {
        super();

        // Setup positioning information
        this.positions = [Point.clone(head)];
        this.lastTail = this.positions[0];

        // Direction => Human Readable Cardinal Direction
        // Velocity => Actual values we update snake position with
        this.direction = direction;
        this.velocityMap = velocityMap;
        this.velocity = velocityMap[direction];

        // Setup actual blocks to be rendered
        this.color = color;
        this.cellWidth = cellWidth;
        this.cellHeight = cellHeight;
        this.blocks = new Array<Shape>();
        this.blocks.push(new Shape());
        Lib.current.stage.addChild(this.blocks[0]);

        // Set states
        this.dead = false;
        this.ateApple = false;
    }

    public function move(desired: Direction) {
        // Change the player velocity if they're not trying to travel in an opposing
        // direction
        var okNorth = desired == Direction.North && direction != Direction.South;
        var okSouth = desired == Direction.South && direction != Direction.North;
        var okEast = desired == Direction.East && direction != Direction.West;
        var okWest = desired == Direction.West && direction != Direction.East;

        if (okNorth || okSouth || okEast || okWest) {
            this.velocity = this.velocityMap[desired];
            this.direction = desired;
        }
    }

    public function update() {
        /*
            Grow Snake
        */

        // Record the new free cell that moving the snake always produces
        lastTail = Point.clone(this.positions[this.positions.length - 1]);

        // Update the body of the snake.
        var i = this.positions.length - 1;
        while (i > 0) {
            this.positions[i].x = this.positions[i - 1].x;
            this.positions[i].y = this.positions[i - 1].y;
            --i;
        }

        // Update the head of the snake.
        this.positions[0].x += this.velocity.x;
        this.positions[0].y += this.velocity.y;

        // Grow if we ate an apple
        if (this.ateApple) {
            this.positions.push(Point.clone(lastTail));
            this.blocks.push(new Shape());
            Lib.current.stage.addChild(this.blocks[this.blocks.length - 1]);
            this.ateApple = false;
        }
    }

    public function render() {
        for (i in 0 ... this.blocks.length) {
            this.blocks[i].graphics.beginFill(this.color);
            this.blocks[i].graphics.drawRect(0, 0, this.cellWidth, this.cellHeight);
            this.blocks[i].x = this.positions[i].x;
            this.blocks[i].y = this.positions[i].y;
        }
    }

    public function die() {
        this.dead = true;
        for (i in 0 ... this.positions.length) {
            Lib.current.stage.removeChild(this.blocks[i]);
        }
    }

    public function isDead() {
        return this.dead;
    }

    public function consumeApple() {
        this.ateApple = true;
    }

    public function getPositions(): Array<Point> {
        return this.positions;
    }

    public function getHead(): Point {
        return this.positions[0];
    }

    public function getLastTail(): Point {
        return this.lastTail;
    }

    public function getDirection(): Direction {
        return this.direction;
    }
}