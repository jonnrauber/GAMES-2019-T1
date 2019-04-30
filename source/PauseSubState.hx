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

        _txtPause = new FlxText(0, 0, 0, "PAUSE GAME", 20);
        _txtPause.screenCenter(FlxAxes.X);
        _txtPause.y = 100;

        _btnResume = new FlxButton(0, 0, "Resume", onResume);
        _btnResume.screenCenter(FlxAxes.X);
        _btnResume.y = _txtPause.y + 100;

        _btnBackToMenu = new FlxButton(0, 0, "Leave to Menu", onBack);
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