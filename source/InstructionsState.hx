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
        _titulo = new FlxText(0,0,0, "Instructions");
        _titulo.antialiasing = true;
        _titulo.setFormat(AssetPaths.Caveat_Bold__ttf, 32, 0xffffffff);
        _titulo.screenCenter(FlxAxes.X);
        _titulo.y = 50;

        _resume = new FlxText(0,0,0, "Don't leave the productivity be zero!");
        _resume.antialiasing = true;
        _resume.setFormat(AssetPaths.Quicksand_Regular__ttf, 18, 0xffffffff);
        _resume.screenCenter(FlxAxes.X);
        _resume.y = _titulo.y + _titulo.height + 10;

        _sprMouseLeft = new FlxSprite();
        _sprMouseLeft.loadGraphic(AssetPaths.mouse_left__png, false);
        _sprMouseLeft.setGraphicSize(48,48);
        _sprMouseLeft.x = 140;
        _sprMouseLeft.y = _resume.y + _resume.height + 30;

        _txtMouseLeft = new FlxText(0, 0, 0, "Moves boss");
        _txtMouseLeft.antialiasing = true;
        _txtMouseLeft.setFormat(AssetPaths.Quicksand_Regular__ttf, 16, 0xffffffff);
        _txtMouseLeft.x = _sprMouseLeft.x + _sprMouseLeft.width + 10;
        _txtMouseLeft.y = _sprMouseLeft.y + (_sprMouseLeft.height-_txtMouseLeft.height)/2;

        _sprMouseRight = new FlxSprite();
        _sprMouseRight.loadGraphic(AssetPaths.mouse_right__png, false);
        _sprMouseRight.setGraphicSize(48,48);
        _sprMouseRight.x = 140;
        _sprMouseRight.y = _sprMouseLeft.y + _sprMouseLeft.height + 20;

        _txtMouseRight = new FlxText(0, 0, 0, "Throws warning to programmer");
        _txtMouseRight.antialiasing = true;
        _txtMouseRight.setFormat(AssetPaths.Quicksand_Regular__ttf, 16, 0xffffffff);
        _txtMouseRight.x = _sprMouseRight.x + _sprMouseRight.width + 10;
        _txtMouseRight.y = _sprMouseRight.y + (_sprMouseRight.height-_txtMouseRight.height)/2;

        _sprSpaceBar = new FlxSprite();
        _sprSpaceBar.loadGraphic(AssetPaths.spacebar__png, false);
        _sprSpaceBar.setGraphicSize(48,48);
        _sprSpaceBar.x = 140;
        _sprSpaceBar.y = _sprMouseRight.y + _sprMouseRight.height + 20;

        _txtSpaceBar = new FlxText(0, 0, 0, "Order programmer to get back work");
        _txtSpaceBar.antialiasing = true;
        _txtSpaceBar.setFormat(AssetPaths.Quicksand_Regular__ttf, 16, 0xffffffff);
        _txtSpaceBar.x = _sprSpaceBar.x + _sprSpaceBar.width + 10;
        _txtSpaceBar.y = _sprSpaceBar.y + (_sprSpaceBar.height-_txtSpaceBar.height)/2;

        _btnVoltar = new FlxButton(0, 0, "Back", goMenu);
        _btnVoltar.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnVoltar.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
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