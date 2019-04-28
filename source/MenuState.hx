package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var _title:FlxText;
    var _btnPlay:FlxButton;
    var _btnSettings:FlxButton;
    var _btnCredits:FlxButton;

	override public function create():Void
	{
		_title = new FlxText("GO TO WORK!");
		//Do you see that ferrari? Work hard and you can help me buy it.
		_title.size = 20;
		_title.screenCenter();
		_title.y = 100;

		_btnPlay = new FlxButton(0, 0, "START GAME", goPlay);
		_btnPlay.screenCenter();

		_btnSettings = new FlxButton(0, 0, "SETTINGS", goSettings);
		_btnSettings.screenCenter();
		_btnSettings.y = _btnPlay.y + _btnPlay.height + 10;

		_btnCredits = new FlxButton(0, 0, "CREDITS", goCredits);
		_btnCredits.screenCenter();
		_btnCredits.y = _btnSettings.y + _btnSettings.height + 10;

		add(_btnCredits);
		add(_btnSettings);
		add(_btnPlay);
		add(_title);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function goPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function goSettings()
	{
		FlxG.switchState(new SettingsState());
	}

	function goCredits()
	{
		FlxG.switchState(new CreditsState());
	}
}
