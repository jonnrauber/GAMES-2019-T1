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
        this.animation.add("down", [0,1,2,3], 15);
        this.animation.add("left", [4,5,6,7], 15);
        this.animation.add("right", [8,9,10,11], 15);
        this.animation.add("up", [12,13,14,15], 15);
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        
    }
}