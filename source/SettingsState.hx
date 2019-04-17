package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class SettingsState extends FlxState {
    var _titulo:FlxText;
    var _btnVoltar:FlxButton;
    var _btnFullScreen:FlxButton;

    override public function create():Void {
        _titulo = new FlxText(0,0,0, "Settings", 20);
        _titulo.screenCenter();
        _titulo.y = 100;

        _btnVoltar = new FlxButton(0, 0, "Back", goMenu);
        _btnVoltar.x = FlxG.width - _btnVoltar.width - 10;
        _btnVoltar.y = FlxG.height - _btnVoltar.height - 10;

        _btnFullScreen = new FlxButton(0, 0, "Toggle Fullscreen", toggleFullscreen);
        _btnFullScreen.screenCenter();

        add(_titulo);
        add(_btnVoltar);
        add(_btnFullScreen);
        super.create();
    }

    function goMenu():Void {
        FlxG.switchState(new MenuState());
    }

    function toggleFullscreen():Void {
        FlxG.fullscreen = !FlxG.fullscreen;
    }
}