/*
    World.hx
    Author: Samuel Vargas
*/

package ;

interface World {
    public function reset(): Void;
    public function getAvailableRandomSpawn(): Point;
    public function add(p: Point, id: UInt): Void;
    public function del(p: Point): Void;
    public function itemAt(p: Point): Null<UInt>;
}