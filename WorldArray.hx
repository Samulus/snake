/*
    WorldArray.hx
    Author: Samuel Vargas

    ID System:
        > 0   .............. Snake ID
        0     .............. Cell is Empty
        < 0   .............. Apple
*/

package ;

class WorldArray implements World {
    private var cells: Array<Int>;
    private var screenWidth: UInt;
    private var screenHeight: UInt;
    private var cellHeight: UInt;
    private var cellWidth: UInt;
    private var numColumns: UInt;

    public function new(screenWidth: UInt, screenHeight: UInt,
                        cellWidth: UInt, cellHeight: UInt) {
        this.screenWidth = screenWidth;
        this.screenHeight = screenHeight;
        this.cellWidth = cellWidth;
        this.cellHeight = cellHeight;
        this.numColumns = cast screenWidth / cellWidth;
        cells = new Array<Int>();
        reset();
    }

    public function reset(): Void {
        cells.splice(0, cells.length);
        var y: UInt = 0;
        while (y < screenHeight) {
            var x: UInt = 0;
            while (x < screenWidth) {
                cells.push(0);
                x += cellWidth;
            }
            y += cellHeight;
        }
    }

    public function add(p: Point, id: Int): Void {
        cells[toIndex(p)] = id;
    }

    public function del(p: Point): Void {
        cells[toIndex(p)] = 0;
    }

    public function itemAt(p: Point): Null<UInt> {
        return cells[toIndex(p)];
    }

    public function getAvailableRandomSpawn(): Point {
        var index = Std.random(cells.length);

        // 1) Attempt to use random index
        if (cells[index] == 0) {
            return fromIndex(index);
        }

        // 2) Walk to left of index until first cell is available
        var lwalk = index - 1;
        while (lwalk >= 0) {
            if (cells[lwalk] == 0) {
                return fromIndex(lwalk);
            }
            lwalk--;
        }

        // 3) Walk to right of index until first cell is available
        var rwalk = index + 1;
        while (rwalk < cells.length) {
            if (cells[rwalk] == 0) {
                return fromIndex(rwalk);
            }
            rwalk--;
        }

        trace("Board is filled! Game should end");
        return null;
    }

    private function fromIndex(i: UInt): Point {
        // 1D Array coordinates -> 2D -> Screen
        var xIndex: Int = i % numColumns;
        var yIndex: Int = cast i / numColumns;
        return new Point(xIndex * cellWidth, yIndex * cellHeight);
    }

    private function toIndex(p: Point): Int {
        // Screen -> 2D Array -> 1D Array coordinates
        var xIndex = p.x / cellWidth;
        var yIndex = p.y / cellHeight;
        return cast xIndex + yIndex * numColumns;
    }
}