/*
    Shuffle.hx
    Author: Samuel Vargas
*/

package ;

class Shuffle {
    public static function fisherYates(arr: Array<Point>) {
        var i = arr.length - 1;
        while (i > 0) {
            var j = Std.random(i + 1);
            var tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
            --i;
        }
    }
}