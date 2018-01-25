/*
    Entity.hx
    Author: Samuel Vargas

    ID System:
        > 0   .............. Snake ID
        0     .............. Cell is Empty
        < 0   .............. Apple
*/

package ;

class Entity {
    private static var ATOMIC_ID = 1;
    private var id: Int = 0;

    private function new() {
        id = ATOMIC_ID;
        ATOMIC_ID++;
    }

    public function getID(): Int {
        return this.id;
    }
}