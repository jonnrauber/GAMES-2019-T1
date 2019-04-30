package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var _title:FlxText;
    var _btnPlay:FlxButton;
    var _btnInstructions:FlxButton;
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

		_btnInstructions = new FlxButton(0, 0, "INSTRUCTIONS", goInstructions);
		_btnInstructions.screenCenter();
		_btnInstructions.y = _btnPlay.y + _btnPlay.height + 10;

		_btnCredits = new FlxButton(0, 0, "CREDITS", goCredits);
		_btnCredits.screenCenter();
		_btnCredits.y = _btnInstructions.y + _btnInstructions.height + 10;

		add(_btnCredits);
		add(_btnInstructions);
		add(_btnPlay);
		add(_title);

		super.create();
	}

	override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER) {
            goPlay();
        }
    }

	function goPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function goInstructions()
	{
		FlxG.switchState(new InstructionsState());
	}

	function goCredits()
	{
		FlxG.switchState(new CreditsState());
	}
}
