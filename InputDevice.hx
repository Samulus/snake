/*
    InputDevice.hx
    Author: Samuel Vargas
*/

package ;

interface InputDevice {
    public function update(snake: Snake, apple: Apple): Void;
    public function getDirection(): Direction;
}
