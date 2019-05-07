package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;

class HUD extends FlxGroup {
    var _txtTime:FlxText;
    var _sprTime:FlxText;
    var _txtProductivity:FlxText;
    var _sprProductivity:FlxBar;
    var _productivity:FlxSprite;

    public function new() {
        super();

        _productivity = new FlxSprite();

        _sprProductivity = new FlxBar(
          0, 0, LEFT_TO_RIGHT, 100, 14, _productivity, "health", 0, 1000, true   
        );
        _sprProductivity.x = FlxG.width - _sprProductivity.width - 17;
        _sprProductivity.y = FlxG.height - _sprProductivity.height - 17;

        _txtProductivity = new FlxText(0, 0, 0, "Productivity: ");
        _txtProductivity.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xffffffff);
        _txtProductivity.x = _sprProductivity.x - _txtProductivity.width;
        _txtProductivity.y = _sprProductivity.y - 5;
        _txtProductivity.color = new FlxColor(0xff000000);

        _sprTime = new FlxText(0, 0, 0, "00:00");
        _sprTime.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xffffffff);
        _sprTime.x = FlxG.width - _sprTime.width - 15;
        _sprTime.y = FlxG.height - _sprTime.height - 30;
        _sprTime.color = new FlxColor(0xff000000);
        
        _txtTime = new FlxText(0, 0, 0, "Time: ");
        _txtTime.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xffffffff);
        _txtTime.x = _sprTime.x - _txtTime.width;
        _txtTime.y = _sprTime.y;
        _txtTime.color = new FlxColor(0xff000000);

        add(_txtTime);
        add(_sprTime);
        add(_txtProductivity);
        add(_sprProductivity);
    }

    public function updateHUD(time:Float, productivity:Int):Void {
      _productivity.health = productivity;
      _sprTime.text = DateTools.format(Date.fromTime(time), "%M:%S");
    }
}