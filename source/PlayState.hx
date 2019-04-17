package;

import flixel.FlxState;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	var _player:FlxSprite;

	override public function create():Void
	{
		_player = new FlxSprite();
		_player.makeGraphic(20, 20, 0xffff0000);
		_player.screenCenter();

		add(_player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
