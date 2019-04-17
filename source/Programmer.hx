package;

import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Programmer extends Entity
{
    var _timeToCoffee:Int;
    var _workLocation:FlxPoint;

    public function new() {
        super();
        _timeToCoffee = 0;
        _workLocation = new FlxPoint(0, 0);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        _timeToCoffee += 1;
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);

        if (m.op == Message.OP_GO_WORK) {
            goWork();
            this._timeToCoffee = 0;
            FlxG.log.add("Recebeu uma chamada do chefe!");
        }
    }

    public function goWork():Void {
        this.path = new FlxPath().start(
            [_workLocation],
            200,
            FlxPath.FORWARD
        );
    }
}