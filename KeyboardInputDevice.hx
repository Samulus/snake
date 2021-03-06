/*
    KeyboardInputDevice.hx
    Author: Samuel Vargas
*/

package ;

class KeyboardInputDevice implements InputDevice {

    private var north: UInt;
    private var south: UInt;
    private var east: UInt;
    private var west: UInt;
    private var direction: Direction;

    public function new(north: UInt, south: UInt, east: UInt, west: UInt) {
        this.north = north;
        this.south = south;
        this.west = west;
        this.east = east;
    }

    public function getDirection(snake: Snake, apple: Apple): Direction {
        if (GlobalKeyboardInput.isPressed(north)) {
            direction = Direction.North;
        }

        else if (GlobalKeyboardInput.isPressed(south)) {
            direction = Direction.South;
        }

        else if (GlobalKeyboardInput.isPressed(east)) {
            direction = Direction.East;
        }

        else if (GlobalKeyboardInput.isPressed(west)) {
            direction = Direction.West;
        }

        return direction;
    }

}
