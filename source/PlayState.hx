package;

import flixel.math.FlxPoint;
import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	var _postOffice:PostOffice;
	var _boss:Boss;
	var _programmer:Programmer;

	override public function create():Void
	{
		_postOffice = new PostOffice();

		_boss = new Boss();
		_boss.makeGraphic(20, 20, 0xffff0000);
		_boss.screenCenter();

		_programmer = new Programmer();
		_programmer.makeGraphic(20, 20, 0xff00ff00);
		_programmer.x = 100;
		_programmer.y = 100;

		add(_postOffice);
		add(_boss);
		add(_programmer);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed) {
			_boss.path = new FlxPath().start(
				[new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)], 
				100, 
				FlxPath.FORWARD);
		}

		//If Boss collides to Programmer, Boss demands to Programmer to go work
		if (FlxG.overlap(_boss, _programmer)) {
            var m:Message = new Message();
            m.from = _boss;
            m.to = _programmer;
            m.op = Message.OP_GO_WORK;
            m.data = 2;
            _postOffice.send(m);
        }
	}
}
