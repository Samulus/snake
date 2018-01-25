/*
    GlobalMouseInput.hx
    Author: Samuel Vargas
*/

package ;

import flash.display.Stage;
import flash.events.MouseEvent;

class GlobalMouseInput {

    private static var stage: Stage;
    private static var clickPoint: Point;

    public static function init(stage: Stage) {
        GlobalMouseInput.stage = stage;
        GlobalMouseInput.stage.addEventListener(MouseEvent.CLICK, onClick);
    }

    public static function getLastClickPoint(): Null<Point> {
        var tmp = clickPoint;
        clickPoint = null;
        return tmp;
    }

    private static function onClick(event: MouseEvent) {
        clickPoint = new Point(cast event.stageX, cast event.stageY);
    }
}