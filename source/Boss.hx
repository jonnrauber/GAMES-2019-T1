package;

import flixel.FlxObject;

class Boss extends Entity
{
    var _companyProdutivity:Int;

    public function new() {
        super();
        _companyProdutivity = 0;

        this.loadGraphic(AssetPaths.boss__png, true, 32, 48);
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
		this.facing = FlxObject.RIGHT;
        this.animation.add("down", [0,1,2,3], 20);
        this.animation.add("left", [4,5,6,7], 20);
        this.animation.add("right", [8,9,10,11], 20);
        this.animation.add("up", [12,13,14,15], 20);
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

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
            this.animation.stop();
        }
    }
}