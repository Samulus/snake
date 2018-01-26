/*
    WorldArray.hx
    Author: Samuel Vargas
*/

package ;

class WorldArray implements World {
    private var cells: Array<CellType>;
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
        this.numColumns = cast (screenWidth - cellWidth) / cellWidth;
        reset();
    }

    public function reset(): Void {
        cells = new Array<CellType>();
        var y: UInt = 0;
        while (y < screenHeight - cellHeight) {
            var x: UInt = 0;
            while (x < screenWidth - cellWidth) {
                cells.push(CellType.Empty);
                x += cellWidth;
            }
            y += cellHeight;
        }
    }

    public function add(p: Point, type: CellType): Void {
        cells[toIndex(p)] = type;
    }

    public function del(p: Point): Void {
        cells[toIndex(p)] = CellType.Empty;
    }

    public function itemAt(p: Point): CellType {
        return cells[toIndex(p)];
    }

    public function getAvailableRandomSpawn(): Point {
        var index = Std.random(cells.length);

        // 1) Attempt to use random index
        if (cells[index] == CellType.Empty) {
            return fromIndex(index);
        }

        // 2) Walk to left of index until first cell is available
        var lwalk = index - 1;
        while (lwalk >= 0) {
            if (cells[lwalk] == CellType.Empty) {
                return fromIndex(lwalk);
            }
            lwalk--;
        }

        // 3) Walk to right of index until first cell is available
        var rwalk = index + 1;
        while (rwalk < cells.length) {
            if (cells[rwalk] == CellType.Empty) {
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

    private function toIndex(p: Point): UInt {
        // Screen -> 2D Array -> 1D Array coordinates
        var xIndex = p.x / cellWidth;
        var yIndex = p.y / cellHeight;
        return cast xIndex + yIndex * numColumns;
    }
}