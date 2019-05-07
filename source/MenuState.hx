package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var _title:FlxSprite;
    var _btnPlay:FlxButton;
    var _btnInstructions:FlxButton;
    var _btnCredits:FlxButton;

	override public function create():Void
	{
		_title = new FlxSprite();
		_title.loadGraphic(AssetPaths.banner__png);
		_title.screenCenter();
		_title.y = 100;
		_title.setGraphicSize(400, 100);

		_btnPlay = new FlxButton(0, 0, "Start Game", goPlay);
		_btnPlay.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnPlay.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
		_btnPlay.screenCenter();

		_btnInstructions = new FlxButton(0, 0, "Instructions", goInstructions);
		_btnInstructions.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnInstructions.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
		_btnInstructions.screenCenter();
		_btnInstructions.y = _btnPlay.y + _btnPlay.height + 10;

		_btnCredits = new FlxButton(0, 0, "Credits", goCredits);
		_btnCredits.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnCredits.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
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
