/*
    CPUInputDevice.hx
    Author: Samuel Vargas

    Barebones A.I. to illustrate extensibility of InputDevice interface. A
    more sophisticated A.I. that doesn't run into itself or watches out for
    other players could easily be implemented in the future.
*/

package ;

class CPUInputDevice implements InputDevice {

    private var direction: Direction;

    public function new() {}

    public function getDirection(snake: Snake, apple: Apple): Direction {
        var head = snake.getHead();
        var food = apple.getPosition();
        var tmpDirection = snake.getDirection();
        var needGoNorth = (head.y > food.y);
        var needGoEast = (head.x > food.x);

        // Correct Y direction if required
        if ((head.x != food.x) &&
           ((needGoEast && tmpDirection == Direction.West) ||
           (!needGoEast && tmpDirection == Direction.East))) {
            direction = needGoNorth ? Direction.North : Direction.South;
        }

        // Correct X direction if required
        if ((needGoNorth && tmpDirection == Direction.South) ||
           (!needGoNorth && tmpDirection == Direction.North)) {
            direction = needGoEast ? Direction.East : Direction.West;
        }

        return direction;
    }
}
