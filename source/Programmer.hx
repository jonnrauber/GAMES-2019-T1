package;

import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Programmer extends Entity
{
    public static inline var WORKING_STATE = 0;
    public static inline var COFFEE_STATE = 1;
    public static inline var MEMES_STATE = 2;

    var _timeToCoffee:Int;
    var _workLocation:FlxPoint;
    public var _state:Int; //0: working, 1: coffee, 2: memes

    public function new() {
        super();
        _timeToCoffee = 0;
        _workLocation = new FlxPoint(0, 0);
        _state = WORKING_STATE;
        this.loadGraphic(AssetPaths.programmer__png, true, 32, 32);
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
		this.facing = FlxObject.RIGHT;
        this.animation.add("down", [0,1,2,3], 15);
        this.animation.add("up", [4,5,6,7], 15);
        this.animation.add("left", [8,9,10,11], 15);
        this.animation.add("right", [12,13,14,15], 15);
        this.animation.add("idle", [4], 15);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        _timeToCoffee += 1;

        if (this._state == WORKING_STATE  && this._timeToCoffee > 300) {
            goCoffee();
        }

        if (this.path != null && this.path.active) {
            if (this.path.angle >= 45 && this.path.angle < 135) {
                this.animation.play("right");
            }
            if ((this.path.angle >= 135 && this.path.angle <= 180) ||
                    (this.path.angle >= -180 && this.path.angle <= -135)) {
                this.animation.play("down");
            }
            if (this.path.angle > -135 && this.path.angle < -45) {
                this.animation.play("left");
            }
            if ((this.path.angle >= -45 && this.path.angle < 45)) {
                this.animation.play("up");
            }
        } else {
            this.animation.play("idle");
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
        this._state = WORKING_STATE;
    }

    public function goCoffee():Void {
        this.path = new FlxPath().start(
            [new FlxPoint(550, 320)],
            200,
            FlxPath.FORWARD
        );
        this._state = COFFEE_STATE;
    }

    public function setWorkLocation(x:Int, y:Int):Void {
        this.x = x - this.width/2;
        this.y = y - this.height/2;
        this._workLocation = new FlxPoint(x, y);
    }
}