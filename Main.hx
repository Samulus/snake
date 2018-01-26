/*
    Main.hx
    Author: Samuel Vargas
*/

package ;

import flash.Lib;

class Main {

    static private var apple: Apple;
    static private var world: World;
    static private var gameTimer: haxe.Timer;

    static public function main() {
        // Setup Global Inputs
        GlobalKeyboardInput.init(Lib.current.stage);
        GlobalMouseInput.init(Lib.current.stage);

        // Setup Static Systems
        SnakeManager.init(Settings.CELL_WIDTH,
                          Settings.CELL_HEIGHT,
                          Settings.SCREEN_WIDTH,
                          Settings.SCREEN_HEIGHT,
                          Settings.SNAKE_VELOCITIES);

        // Setup World + Singular Apple
        world = new WorldArray(Settings.SCREEN_WIDTH,
                               Settings.SCREEN_HEIGHT,
                               Settings.CELL_WIDTH,
                               Settings.CELL_HEIGHT);

        apple = new Apple(world.getAvailableRandomSpawn());

        // Setup all initial object states + delay before starting main loop
        reset();
        delayBeforeGame();
    }

    // Reset the entire state of the game
    static public function reset(): Void {
        SnakeManager.reset();
        world.reset();

        // Spawn Snakes for Players
        for (player in Settings.Players) {
            player.reset();
            var spawn = world.getAvailableRandomSpawn();
            var snake = SnakeManager.spawnSnake(spawn, player.getColor(), world);
            player.attachSnake(snake);
        }

        // Place the apple in a random location
        apple.setPosition(world.getAvailableRandomSpawn());
        world.add(apple.getPosition(), CellType.Apple);
        render();
    }

    static public function delayBeforeGame() {
        // Wait Settings.MS_DELAY_BEFORE_GAME to start accepting input
        // This is so the player can see where they are on screen prior to
        // the game starting.
        GetReady.display();
        haxe.Timer.delay(
            function() {
                GetReady.clear();
                gameTimer = new haxe.Timer(Settings.MS_PER_UPDATE);
                gameTimer.run = loop;
            }, Settings.MS_DELAY_BEFORE_GAME);
    }

    static public function loop(): Void {
        input();
        update();
        render();
    }

    // Accept input from all keyboards, mouse, AI units, replay systems etc.
    static public function input(): Void {
        for (player in Settings.Players) {
            var input = player.getInputDevice();
            var snake = player.getSnake();
            var direction = input.getDirection(snake, apple);
            snake.move(direction);
        }
    }

    // Process logic for each snake, ignore dead snakes.
    static public function update(): Void {
        for (player in Settings.Players) {
            var snake = player.getSnake();
            if (snake.isDead()) {
                continue;
            }

            snake.update();
            SnakeManager.maybeKillSnake(snake, world);
            if (SnakeManager.maybeEatApple(snake, apple, world)) {
                player.incrementScore();
            }

            SnakeManager.updateWorld(snake, world);
        }

        // Game ends when all the snakes die.
        if (SnakeManager.getCount() <= 0) {
            // Print out winners
            gameTimer.stop();
            GameOver.display(Settings.Players);

            // After MS_DELAY_BETWEEN_GAMES elapses, restart the game.
            haxe.Timer.delay(
                function() {
                    GameOver.clear();
                    reset();
                    delayBeforeGame();
                }, Settings.MS_DEALY_GAME_OVER);
        }
    }

    // Render everything!
    static public function render(): Void {
        for (player in Settings.Players) {
            var snake = player.getSnake();
            snake.render();
        }
        apple.render();
    }
}
