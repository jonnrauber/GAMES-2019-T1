package;

import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Programmer extends Entity
{
    var _timeToCoffee:Int;
    var _workLocation:FlxPoint;
    var _workingState:Bool;

    public function new() {
        super();
        _timeToCoffee = 0;
        _workLocation = new FlxPoint(0, 0);
        _workingState = true;
        this.loadGraphic(AssetPaths.programmer__png, true, 32, 32);
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
		this.facing = FlxObject.RIGHT;
        this.animation.add("up", [4,5,6,7], 15);
        this.animation.add("down", [0,1,2,3], 15);
        this.animation.add("left", [8,9,10,11], 15);
        this.animation.add("right", [12,13,14,15], 15);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        _timeToCoffee += 1;

        if (_timeToCoffee > 1000) {
            goCoffee();
        }
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);

        if (m.op == Message.OP_GO_WORK) {
            goWork();
            this._timeToCoffee = 0;
        }
    }

    public function goWork():Void {
        this.path = new FlxPath().start(
            [_workLocation],
            100,
            FlxPath.FORWARD
        );
    }

    public function goCoffee():Void {
        this.path = new FlxPath().start(
            [new FlxPoint(550, 320)],
            200,
            FlxPath.FORWARD
        );
    }

    public function setWorkLocation(x:Int, y:Int):Void {
        this.x = x - this.width/2;
        this.y = y - this.height/2;
        this._workLocation = new FlxPoint(x, y);
    }
}