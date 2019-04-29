package;

class Warning extends Entity
{
    public function new() {
        super();
        this.makeGraphic(5, 5, 0xffff0000);
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