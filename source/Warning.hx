package;

class Warning extends Entity
{
    public function new() {
        super();
        this.loadGraphic(AssetPaths.warning__png, true, 32, 32);
        this.scale.x = 0.75;
        this.scale.y = 0.75;
        this.kill();
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (! this.isOnScreen()) {
            this.kill();
        }
     }
}