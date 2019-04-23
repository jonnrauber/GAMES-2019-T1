package;

import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Programmer extends Entity
{
    var _timeToCoffee:Int;
    var _workLocation:FlxPoint;

    public function new() {
        super();
        _timeToCoffee = 0;
        _workLocation = new FlxPoint(0, 0);
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

        if (FlxG.keys.pressed.LEFT) {
            this.x -= 1;
            this.animation.play("left");
        }
        if (FlxG.keys.pressed.RIGHT) {
            this.x += 1;
            this.animation.play("right");
        }
        if (FlxG.keys.pressed.UP) {
            this.y -= 1;
            this.animation.play("up");
        }
        if (FlxG.keys.pressed.DOWN) {
            this.y += 1;
            this.animation.play("down");
        }


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