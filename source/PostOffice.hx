package;

import flixel.FlxObject;

class PostOffice extends FlxObject {
    var _fila:Array<Message> = [];

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        for (m in _fila) {
            m.to.onMessage(m);
        }

        _fila.splice(0, _fila.length);
    }

    public function send(m:Message):Void {
        _fila.push(m);
    }

}