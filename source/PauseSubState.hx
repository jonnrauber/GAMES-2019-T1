package;

import flixel.util.FlxAxes;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class PauseSubState extends FlxSubState {

    var _txtPause:FlxText;
    var _btnResume:FlxButton;
    var _btnBackToMenu:FlxButton;

    override public function create():Void {
        super.create();

        _txtPause = new FlxText(0, 0, 0, "Pause Game", 20);
        _txtPause.setFormat(AssetPaths.Quicksand_Regular__ttf, 20, 0xffffffff);
        _txtPause.screenCenter(FlxAxes.X);
        _txtPause.y = 100;

        _btnResume = new FlxButton(0, 0, "Resume", onResume);
        _btnResume.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnResume.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
        _btnResume.screenCenter(FlxAxes.X);
        _btnResume.y = _txtPause.y + 100;

        _btnBackToMenu = new FlxButton(0, 0, "Leave to Menu", onBack);
        _btnBackToMenu.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnBackToMenu.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
        _btnBackToMenu.screenCenter(FlxAxes.X);
        _btnBackToMenu.y = _btnResume.y + 50;

        add(_txtPause);
        add(_btnResume);
        add(_btnBackToMenu);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
            onResume();
    }

    function onResume():Void {
        close();
    }

    function onBack():Void {
        FlxG.switchState(new MenuState());
    }
}