/*
    Point.hx
    Author: Samuel Vargas
*/

package ;

class Point {
    public var x: Int;
    public var y: Int;

    public function new(x: Int, y: Int) {
        this.x = x;
        this.y = y;
    }

    public static function clone(p: Point) {
        return new Point(p.x, p.y);
    }

    public function equals(lhs: Point, rhs: Point): Bool {
        return (lhs.x == rhs.x && lhs.y == rhs.y);
    }
}