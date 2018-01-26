/*
    SnakeManager.hx
    Author: Samuel Vargas
*/

package ;

class SnakeManager {
    private static var SnakeCount = 0;
    private static var cellWidth: Int;
    private static var cellHeight: Int;
    private static var screenWidth: Int;
    private static var screenHeight: Int;
    private static var velocityMap: Map<Direction, Point>;

    public static function init(cellWidth: Int, cellHeight: Int,
                                screenWidth: Int, screenHeight: Int,
                                velocityMap: Map<Direction, Point>) {

        SnakeManager.cellWidth = cellWidth;
        SnakeManager.cellHeight = cellHeight;
        SnakeManager.screenWidth = screenWidth;
        SnakeManager.screenHeight = screenHeight;
        SnakeManager.velocityMap = velocityMap;
    }

    public static function reset() {
        SnakeCount = 0;
    }

    public static function getCount() {
        return SnakeCount;
    }

    public static function spawnSnake(p: Point, color: UInt, world: World): Snake {
        SnakeCount++;
        var tmp = new Snake(p, getSafestDirection(p), velocityMap, color, cellWidth, cellHeight);
        world.add(p, CellType.Snake);
        return tmp;
    }

    public static function maybeKillSnake(snake: Snake, world: World) {
        var head = snake.getHead();

        var outOfBounds = head.x < 0 || head.x > screenWidth - cellWidth || head.y < 0 || head.y > screenHeight - cellHeight;
        var snakeCollision = world.itemAt(head) == CellType.Snake;

        if (outOfBounds || snakeCollision) {
            SnakeCount--;
            for (position in snake.getPositions()) {
                world.del(position);
            }
            snake.die();
        }
    }

    public static function maybeEatApple(snake: Snake, apple: Apple, world: World): Bool {
        if (world.itemAt(snake.getHead()) == CellType.Apple) {
            snake.consumeApple();
            world.del(apple.getPosition());
            apple.setPosition(world.getAvailableRandomSpawn());
            world.add(apple.getPosition(), CellType.Apple);
            return true;
        }

        return false;
    }

    public static function updateWorld(snake: Snake, world: World) {
        world.add(snake.getHead(), CellType.Snake);
        world.del(snake.getLastTail());
    }

    private static function getSafestDirection(p: Point): Direction {
        // Check which horizontal distance is the greatest
        var westDelta = p.x;
        var eastDelta = screenWidth - p.x;
        var useWest = westDelta > eastDelta;
        var horizontalGap = useWest ? westDelta : eastDelta;

        // Check which vertical distance is the greatest
        var northDelta = p.y;
        var southDelta = screenHeight - p.y;
        var useNorth = northDelta > southDelta;
        var verticalGap = useNorth ? northDelta : southDelta;

        var direction: Direction;
        if (horizontalGap > verticalGap) {
            direction = useWest ? Direction.West : Direction.East;
        } else {
            direction = useNorth ? Direction.North : Direction.South;
        }

        return direction;
    }
}
