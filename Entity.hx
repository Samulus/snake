/*
    Entity.hx
    Author: Samuel Vargas

    IDs are guaranteed to be positive
*/

package ;

class Entity {
    private static var ATOMIC_ID = 1;
    private var id = 0;

    private function new() {
        id = ATOMIC_ID;
        ATOMIC_ID++;
    }

    public function getID(): UInt {
        return this.id;
    }
}