/*
    InputDevice.hx
    Author: Samuel Vargas
*/
package ;

interface InputDevice {
    public function update(): Void;
    public function getDirection(): Direction;
}