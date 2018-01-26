/*
    World.hx
    Author: Samuel Vargas
*/

package ;

interface World {
    public function reset(): Void;
    public function getAvailableRandomSpawn(): Point;
    public function add(p: Point, type: CellType): Void;
    public function del(p: Point): Void;
    public function itemAt(p: Point): CellType;
}