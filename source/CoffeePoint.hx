package;

import flixel.FlxObject;

class CoffeePoint extends FlxObject {
    var _busy:Bool;

    public function new(X:Float, Y:Float) {
        super();
        this.x = X;
        this.y = Y;
    }
}