/*
    Snake.hx
    Author: Samuel Vargas
*/

package ;
import flash.Lib;
import flash.display.Stage;
import flash.display.Shape;

class Snake extends Entity {

    private static var TOTAL_SNAKES = 0;

    // Rendering Info
    private var blocks: Array<Shape>;
    private var w: Int;
    private var h: Int;
    private var color: UInt;

    // Positional Information
    private var positions: Array<Point>;
    private var lastTail: Point;
    private var velocity: Point;
    private var direction: Direction; // Human readable velocity

    // Screen Info
    private var screenWidth: Int;
    private var screenHeight: Int;
    private var stage: Stage;

    // States
    private var dead: Bool;
    private var ateApple: Bool;
    private var score: UInt;

    public function new(x: Int, y: Int, w: Int, h: Int, color: UInt,
                        screenWidth: Int, screenHeight: Int) {
        super();

        TOTAL_SNAKES++;

        // Setup positioning information
        this.positions = new Array<Point>();
        this.positions.push(new Point(x, y));

        this.lastTail = new Point(x, y);
        this.w = w;
        this.h = h;
        this.color = color;
        this.stage = Lib.current.stage;
        this.score = 0;

        // Setup actual blocks to be rendered
        this.blocks = new Array<Shape>();
        this.blocks.push(new Shape());
        this.stage.addChild(this.blocks[0]);

        // Set Direction + Velocity
        setRandomDirection();

        // Setup Screen Info
        this.screenWidth = screenWidth;
        this.screenHeight = screenHeight;

        // Set states
        this.dead = false;
        this.ateApple = false;
    }

    private function setRandomDirection() {
        // Check which horizontal distance is the greatest
        var westDelta = this.positions[0].x;
        var eastDelta = this.screenWidth - this.positions[0].x;
        var useWest = westDelta > eastDelta;
        var horizontalGap = (useWest) ? westDelta : eastDelta;

        // Check which vertical distance is the greatest
        var northDelta = this.positions[0].y;
        var southDelta = this.screenHeight - this.positions[0].y;
        var useNorth = northDelta > southDelta;
        var verticalGap = (useNorth) ? northDelta : southDelta;
        this.velocity = new Point(0, 0);

        // Set the Direction + Velocity as needed
        if (horizontalGap >= verticalGap) {
            this.direction = (useWest) ? Direction.West : Direction.East;
            this.velocity.x = (useWest) ? -1 * this.w : this.w;
        } else {
            this.direction = (useNorth) ? Direction.North : Direction.South;
            this.velocity.y = (useNorth) ? -1 * this.h : this.h;
        }

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

    public function update(world: World, apple: Apple) {
        if (dead) {
            return;
        }

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
            this.stage.addChild(this.blocks[this.blocks.length - 1]);
            this.ateApple = false;
        }

        /*
            Kill Snake
        */

        // Suicide if Snake has gone out of bounds
        var head = this.positions[0];
        if (head.x < 0 || head.x > screenWidth || head.y < 0 || head.y > screenHeight) {
            die(world);
            return;
        }

        // Suicide if we touch another snake (ourselves included!)
        if (world.itemAt(this.positions[i]) > 0) {
            // If the ID is this.getID() it was a self collision
            // Otherwise its a collision with another snake
            // This info is useful for scoring (i.e you get points when
            // some runs into you)
            die(world);
            return;
        }

        /*
            Eat Apples
        */

        if (world.itemAt(this.getHead()) == apple.getID()) {
            this.ateApple = true;
            this.score += 1;
            world.del(apple.getPosition());
            apple.setPosition(world.getAvailableRandomSpawn());
            world.add(apple.getPosition(), apple.getID());
        }

        /*
            Update World
        */

        world.add(this.getHead(), this.getID());
        world.del(lastTail);
    }

    public function render() {
        if (dead) {
            return;
        }

        for (i in 0 ... this.blocks.length) {
            this.blocks[i].graphics.beginFill(this.color);
            this.blocks[i].graphics.drawRect(0, 0, this.w, this.h);
            this.blocks[i].x = this.positions[i].x;
            this.blocks[i].y = this.positions[i].y;
        }
    }

    public function die(world: World) {
        dead = true;
        TOTAL_SNAKES--;
        for (i in 0 ... this.positions.length) {
            world.del(this.positions[i]);
            this.stage.removeChild(this.blocks[i]);
        }
    }

    public function getScore(): UInt {
        return this.score;
    }

    public function getHead(): Point {
        return this.positions[0];
    }

    /*
        Static Methods
    */

    public static function Count() {
        return TOTAL_SNAKES;
    }

    public static function Reset() {
        TOTAL_SNAKES = 0;
    }
}