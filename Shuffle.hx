/*
    Shuffle.hx
    Author: Samuel Vargas
*/

package ;

class Shuffle {

    public static function fisherYates(arr: Array<Point>) {
        var i = arr.length;
        while (i > 0) {
            var tmp = arr[i];
            i = i - 1;
            var random = Std.random(i);
            arr[i] = arr[random];
            arr[random] = tmp;
        }

    }

}