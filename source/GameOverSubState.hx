package;

import flixel.util.FlxAxes;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class GameOverSubState extends FlxSubState {

    var _btnTryAgain:FlxButton;
    var _btnBackToMenu:FlxButton;
    var _txtTimeScore:FlxText;
    var _txtGameOver:FlxText;
    public var _score:Float;

    override public function create():Void {
        super.create();

        _txtGameOver = new FlxText(0, 0, 0, "GAME OVER!", 20);
        _txtGameOver.screenCenter(FlxAxes.X);
        _txtGameOver.y = 100;

        _txtTimeScore = new FlxText(0, 0, 0, "Time Score: ", 18);
        _txtTimeScore.text += DateTools.format(Date.fromTime(_score), "%M:%S");
        _txtTimeScore.screenCenter(FlxAxes.X);
        _txtTimeScore.y = _txtGameOver.y + 50;

        _btnTryAgain = new FlxButton(0, 0, "Try Again", onTryAgain);
        _btnTryAgain.screenCenter(FlxAxes.X);
        _btnTryAgain.y = _txtTimeScore.y + 50;

        _btnBackToMenu = new FlxButton(0, 0, "Leave to Menu", onBack);
        _btnBackToMenu.screenCenter(FlxAxes.X);
        _btnBackToMenu.y = _btnTryAgain.y + 50;

        add(_txtGameOver);
        add(_txtTimeScore);
        add(_btnTryAgain);
        add(_btnBackToMenu);
    }

    function onTryAgain():Void {
        FlxG.switchState(new PlayState());
    }

    function onBack():Void {
        FlxG.switchState(new MenuState());
    }
}