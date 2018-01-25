/*
    Player.hx
    Author: Samuel Vargas
*/

package ;

class Player {
    private var name: String;
    private var color: UInt;
    private var inputDevice: InputDevice;
    private var snake: Snake;
    private var score: UInt;

    public function new(name: String, color: UInt, inputDevice: InputDevice) {
        this.name = name;
        this.color = color;
        this.inputDevice = inputDevice;
    }

    public function reset() {
        this.score = 0;
    }

    public function attachSnake(snake: Snake) {
        this.snake = snake;
    }

    public function getScore() {
        return this.score;
    }

    public function incrementScore() {
        this.score += 1;
    }

    public function getSnake(): Snake {
        if (snake == null) {
            trace("Missing Snake!");
        }
        return snake;
    }

    public function getName(): String {
        return this.name;
    }

    public function getColor(): UInt {
        return this.color;
    }

    public function getInputDevice(): InputDevice {
        return this.inputDevice;
    }

}
