package;

import flixel.FlxG;
import flixel.util.FlxPath;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Programmer extends Entity
{
    public static inline var WORKING_STATE = 0;
    public static inline var GOING_TO_COFFEE_STATE = 1;
    public static inline var GOING_TO_MEMES_STATE = 2;
    public static inline var COFFEE_STATE = 3;
    public static inline var MEMES_STATE = 4;

    public var _state:Int;

    public var _awayTimer:FlxTimer;
    public var _memesTimer:FlxTimer;
    
    static inline var NEXT_TIME_TO_MEMES = 3.0; //programmer takes 3 seconds to start watch memes

    var _workLocation:FlxPoint;
    var _coffeePoint:CoffeePoint;
    
    public function new() {
        super();

        _awayTimer = new FlxTimer().start(randomAwayTime());
        _awayTimer.active = false;
        
        _state = WORKING_STATE;

        _workLocation = new FlxPoint(0, 0);

        this.loadGraphic(AssetPaths.programmer__png, true, 32, 48);
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
		this.facing = FlxObject.RIGHT;

        this.animation.add("down", [0,1,2,3], 20);
        this.animation.add("left", [4,5,6,7], 20);
        this.animation.add("right", [8,9,10,11], 20);
        this.animation.add("up", [12,13,14,15], 20);
        this.animation.add("idle", [12], 20);
        this.animation.add("coffee", [10], 20);
        
        this.animation.play("idle");
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (this._state == WORKING_STATE) {
            if (this._awayTimer.finished) {
                var goTo:Int = FlxG.random.int(1, 2);
                if (goTo == GOING_TO_COFFEE_STATE)
                    goCoffee();
                else
                    lookForMemes();
            }

        } else if (this._state == GOING_TO_MEMES_STATE) {
            if (this._memesTimer.finished) {
                watchMemes();
            }
        }

        if (this.path != null) {
            if (this.path.finished && this._state == GOING_TO_COFFEE_STATE) {
                this._state = COFFEE_STATE;
                this.animation.play("coffee");
                this.path = null;

            } else if (this.path.active) {
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
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);

        if (m.op == Message.OP_GO_WORK) {
            goWork();
        }
    }

    function randomAwayTime():Float {
        return FlxG.random.float(5, 10);
    }

    public function goWork():Void {
        if (this._state == COFFEE_STATE || this._state == GOING_TO_COFFEE_STATE) {
            var _newCoffeePoint = new CoffeePoint(this._coffeePoint.x, this._coffeePoint.y);
            if (PlayState._coffeePoints.replace(this._coffeePoint, _newCoffeePoint) != null) {
                this.path = new FlxPath().start(
                    [_workLocation],
                    100,
                    FlxPath.FORWARD
                );
            }
        } else {
            this.alpha = 1.0;
        }
        this._state = WORKING_STATE;
        this._awayTimer = new FlxTimer().start(randomAwayTime());
    }

    public function goCoffee():Void {
        _coffeePoint = PlayState.getAvailableCoffeePoint();
        this.path = new FlxPath().start(
            [new FlxPoint(_coffeePoint.x, _coffeePoint.y)],
            100,
            FlxPath.FORWARD
        );
        this._state = GOING_TO_COFFEE_STATE;
    }

    public function lookForMemes():Void {
        this._memesTimer = new FlxTimer().start(NEXT_TIME_TO_MEMES);
        this._state = GOING_TO_MEMES_STATE;
        this.alpha = 0.66;
    }

    public function watchMemes():Void {
        this._state = MEMES_STATE;
        this.alpha = 0.33;
    }

    public function setWorkLocation(x:Int, y:Int):Void {
        this.x = x - this.width/2;
        this.y = y - this.height/2;
        this._workLocation = new FlxPoint(x, y);
    }
}