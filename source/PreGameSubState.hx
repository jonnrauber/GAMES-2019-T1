package;

import flixel.util.FlxAxes;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;

class PreGameSubState extends FlxSubState {

    var _btnPlay:FlxButton;
    var _sprMemes:FlxSprite;
    var _sprCoffee:FlxSprite;
    var _txtPreGame:FlxText;
    var _txtPreGame2:FlxText;
    var _txtPreGame3:FlxText;

    override public function create():Void {
        super.create();

        _txtPreGame = new FlxText(0, 0, 0, "Over time, programmers become unproductive...\nYour company can not broke!");
        _txtPreGame.antialiasing = true;
        _txtPreGame.alignment = 'center';
        _txtPreGame.setFormat(AssetPaths.Quicksand_Bold__ttf, 24);
        _txtPreGame.screenCenter(FlxAxes.X);
        _txtPreGame.y = 50;

        _sprMemes = new FlxSprite();
        _sprMemes.loadGraphic(AssetPaths.instruction_memes__png);
        _sprMemes.setGraphicSize(30, 50);
        _sprMemes.screenCenter(FlxAxes.X);
        _sprMemes.y = _txtPreGame.y + _txtPreGame.height + 20;

        _txtPreGame2 = new FlxText(0, 0, 0, "When programmers' lose opacity of their bodies, it's because\n they are travelling in memes world!\nYou need to RIGHT-CLICK on a programmer to awake him.");
        _txtPreGame2.antialiasing = true;
        _txtPreGame2.alignment = 'center';
        _txtPreGame2.setFormat(AssetPaths.Quicksand_Regular__ttf, 18);
        _txtPreGame2.screenCenter(FlxAxes.X);
        _txtPreGame2.y = _sprMemes.y + _sprMemes.height + 10;

        _sprCoffee = new FlxSprite();
        _sprCoffee.loadGraphic(AssetPaths.instruction_coffee__png);
        _sprCoffee.setGraphicSize(40, 50);
        _sprCoffee.screenCenter(FlxAxes.X);
        _sprCoffee.y = _txtPreGame2.y + _txtPreGame2.height + 20;

        _txtPreGame3 = new FlxText(0, 0, 0, "Moreover, when they walk towards the table in the right, you have\n to send them back to their places, getting close and pressing SPACE.");
        _txtPreGame3.antialiasing = true;
        _txtPreGame3.alignment = 'center';
        _txtPreGame3.setFormat(AssetPaths.Quicksand_Regular__ttf, 18);
        _txtPreGame3.screenCenter(FlxAxes.X);
        _txtPreGame3.y = _sprCoffee.y + _sprCoffee.height + 10;

        _btnPlay = new FlxButton(0, 0, "Play", onPlay);
        _btnPlay.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnPlay.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
        _btnPlay.screenCenter(FlxAxes.X);
        _btnPlay.y = _txtPreGame3.y + _txtPreGame3.height + 10;

        add(_txtPreGame);
        add(_txtPreGame2);
        add(_txtPreGame3);
        add(_sprMemes);
        add(_sprCoffee);
        add(_btnPlay);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
            onPlay();
    }

    function onPlay():Void {
        close();
    }
}