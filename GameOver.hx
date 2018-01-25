/*
    GameOver.hx
    Author: Samuel Vargas

    Displays a message at the top left side of the screen with
    the list of winners (ties are allowed!) at the end of the game.
*/

package ;

import flash.Lib;
import flash.text.TextField;

class GameOver {

    private static var messageField: TextField;

    public static function display(players: Array<Player>) {

        var scoreTable = new Map<UInt, Array<String>>();

        // Place everyones scores in a map
        for (p in players) {
            var key = p.getScore();
            if (!scoreTable.exists(key)) {
                scoreTable[key] = [p.getName()];
            } else {
                scoreTable[key].push(p.getName());
            }
        }

        // Convert the keys to a sorted desecending array
        // Lambda.array(scoreTable.keys()); doesn't compile...
        var tmp = [];
        for (key in scoreTable.keys()) {
            tmp.push(key);
        }

        tmp.sort(function(a, b): Int {
            if (a < b) return 1;
            if (a > b) return -1;
            return 0;
        });

        var max = tmp[0];
        messageField = new TextField();
        messageField.text = "Hi-Score: " + max + " Apples. Winner(s): ";
        messageField.width = Settings.SCREEN_WIDTH;
        for (name in scoreTable[max]) {
            messageField.text += name + " ";
        }
        messageField.text += " (Restarting in " + Settings.MS_DEALY_GAME_OVER + " ms).";
        Lib.current.stage.addChild(messageField);
    }

    public static function clear() {
        Lib.current.stage.removeChild(messageField);
    }

}
