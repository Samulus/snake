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

    public function new(name: String, color: UInt, inputDevice: InputDevice) {
        this.name = name;
        this.color = color;
        this.inputDevice = inputDevice;
        // Due to the Settings.hx configuration every snake has to be spawned at 
    }

    public function attachSnake(snake: Snake) {
        this.snake = snake;
    }

    public function update(world: World, apple: Apple) {
        if (snake == null) {
            trace("Missing Snake!");
        }
        snake.update(world, apple);
    }

    public function move(direction: Direction) {
        if (snake == null) {
            trace("Missing Snake!");
        }
        snake.move(direction);
    }

    public function render() {
        if (snake == null) {
            trace("Missing Snake!");
        }
        snake.render();
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