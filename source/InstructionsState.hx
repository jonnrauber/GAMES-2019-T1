package;

import flixel.util.FlxAxes;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class InstructionsState extends FlxState {
    var _titulo:FlxText;
    var _resume:FlxText;
    var _btnVoltar:FlxButton;
    var _txtMouseLeft:FlxText;
    var _sprMouseLeft:FlxSprite;
    var _txtMouseRight:FlxText;
    var _sprMouseRight:FlxSprite;
    var _txtSpaceBar:FlxText;
    var _sprSpaceBar:FlxSprite;

    override public function create():Void {
        _titulo = new FlxText(0,0,0, "Instructions", 20);
        _titulo.screenCenter(FlxAxes.X);
        _titulo.y = 50;

        _resume = new FlxText(0,0,0, "Don't leave the productivity be zero!", 16);
        _resume.screenCenter(FlxAxes.X);
        _resume.y = _titulo.y + _titulo.height + 10;

        _sprMouseLeft = new FlxSprite();
        _sprMouseLeft.loadGraphic(AssetPaths.mouse_left__png, false, 64, 64);
        _sprMouseLeft.x = 50;
        _sprMouseLeft.y = _resume.y + 80;

        _txtMouseLeft = new FlxText(0, 0, 0, "Moves boss", 14);
        _txtMouseLeft.x = _sprMouseLeft.x + _sprMouseLeft.width + 30;
        _txtMouseLeft.y = _sprMouseLeft.y + (_sprMouseLeft.height-_txtMouseLeft.height)/2;

        _sprMouseRight = new FlxSprite();
        _sprMouseRight.loadGraphic(AssetPaths.mouse_right__png, false, 64, 64);
        _sprMouseRight.x = 55;
        _sprMouseRight.y = _sprMouseLeft.y + _sprMouseLeft.height + 20;

        _txtMouseRight = new FlxText(0, 0, 0, "Throws warning to programmer", 14);
        _txtMouseRight.x = _sprMouseRight.x + _sprMouseRight.width + 30;
        _txtMouseRight.y = _sprMouseRight.y + (_sprMouseRight.height-_txtMouseRight.height)/2;

        _sprSpaceBar = new FlxSprite();
        _sprSpaceBar.loadGraphic(AssetPaths.spacebar__png, false, 64, 64);
        _sprSpaceBar.x = 52;
        _sprSpaceBar.y = _sprMouseRight.y + _sprMouseRight.height + 20;

        _txtSpaceBar = new FlxText(0, 0, 0, "Order programmer to get back work", 14);
        _txtSpaceBar.x = _sprSpaceBar.x + _sprSpaceBar.width + 30;
        _txtSpaceBar.y = _sprSpaceBar.y + (_sprSpaceBar.height-_txtSpaceBar.height)/2;

        _btnVoltar = new FlxButton(0, 0, "Back", goMenu);
        _btnVoltar.x = FlxG.width - _btnVoltar.width - 10;
        _btnVoltar.y = FlxG.height - _btnVoltar.height - 10;

        add(_titulo);
        add(_resume);
        add(_btnVoltar);
        add(_sprMouseRight);
        add(_sprMouseLeft);
        add(_sprSpaceBar);
        add(_txtMouseLeft);
        add(_txtMouseRight);
        add(_txtSpaceBar);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE) {
            goMenu();
        }
    }

    function goMenu():Void {
        FlxG.switchState(new MenuState());
    }
}