/*
    InputDevice.hx
    Author: Samuel Vargas
*/
package ;

interface InputDevice {
    public function update(snake: Snake): Void;
    public function getDirection(): Direction;
}