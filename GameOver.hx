/*
    GameOver.hx
    Author: Samuel Vargas

    If multiple players have the same score print out each player.
*/

import flash.Lib;
import flash.text.TextField;

class GameOver {

    private static var messageField: TextField;

    public static function display(players: Array<Player>) {

        var scoreTable = new Map<UInt, Array<String>>();

        // Place everyones scores in a map
        for (p in players) {
            var key = p.getSnake().getScore();
            if (!scoreTable.exists(key)) {
                scoreTable[key] = [p.getName()];
            } else {
                scoreTable[key].push(p.getName());
            }
        }

        // Convert the keys to a sorted desecending array
        // Lambda.array(scoreTable.keys()); doesn't work...
        var tmp = [];
        for (key in scoreTable.keys()) {
            tmp.push(key);
        }

        tmp.sort(function(a, b): Int {
            if (a < b) return 1;
            if (a > b) return -1;
            return 0;
        });

        var highestKey = tmp[0];
        messageField = new TextField();
        messageField.text = "Game Over. High-Score: " + highestKey + " Apples Eaten. Winner(s): ";
        messageField.width = Settings.SCREEN_WIDTH;
        for (name in scoreTable[highestKey]) {
            messageField.text += name + " ";
        }
        messageField.text += " (Restarting in " + Settings.MS_DEALY_GAME_OVER + " ms).";
        Lib.current.stage.addChild(messageField);
    }

    public static function clear() {
        Lib.current.stage.removeChild(messageField);
    }

}