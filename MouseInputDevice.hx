/*
    MouseInputDevice.hx
    Author: Samuel Vargas
*/

class MouseInputDevice implements InputDevice {

    private var direction: Direction;

    public function new() {}

    public function update(snake: Snake, apple: Apple): Void {
        var clickPoint = GlobalMouseInput.getLastClickPoint();
        var pos = snake.getHead();

        if (clickPoint == null) {
            return;
        }

        var tmpDirection = snake.getDirection();
        // If the snake is travelling horizontally then only allow the mouse
        // clicks to cause the snake to go up or down.
        if (tmpDirection == Direction.East || tmpDirection == Direction.West) {
            if (clickPoint.y > pos.y) {
                direction = Direction.South;
            } else if (clickPoint.y < pos.y) {
                direction = Direction.North;
            }
        }

        // If the snake is traveling vertically then only allow the snake
        // to go left or right
        else if (tmpDirection == Direction.North || tmpDirection == Direction.South) {
            if (clickPoint.x < pos.x) {
                direction = Direction.East;
            } else if (clickPoint.x > pos.x) {
                direction = Direction.West;
            }
        }


    }

    public function getDirection(): Direction {
        return direction;
    }

}