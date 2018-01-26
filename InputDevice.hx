/*
    InputDevice.hx
    Author: Samuel Vargas
*/

package ;

interface InputDevice {
    public function getDirection(snake: Snake, apple: Apple): Direction;
}
