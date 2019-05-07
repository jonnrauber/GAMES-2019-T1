package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class CreditsState extends FlxState {
    var _titulo:FlxText;
    var _subtituloProgramming:FlxText;
    var _subtituloArt:FlxText;
    var _textoAutorProgramming:FlxText;
    var _textoAutorArt:FlxText;
    var _textoHaxeFlixel:FlxText;
    var _spriteHaxeFlixel:FlxSprite;
    var _btnVoltar:FlxButton;

    override public function create():Void {
        _titulo = new FlxText(0,0,0, "Credits");
        _titulo.antialiasing = true;
        _titulo.setFormat(AssetPaths.Caveat_Bold__ttf, 32, 0xffffffff);
        _titulo.x = (FlxG.width - _titulo.width)/2.;
        _titulo.y = FlxG.height/2 - _titulo.height;
        _titulo.moves = true;
        _titulo.velocity.y = -10;

        _subtituloProgramming = new FlxText(0,0,0, "[Programming]");
        _subtituloProgramming.antialiasing = true;
        _subtituloProgramming.setFormat(AssetPaths.Quicksand_Regular__ttf, 16, 0xffff0000);
        _subtituloProgramming.screenCenter();
        _subtituloProgramming.y = _titulo.y + _titulo.height + 30;
        _subtituloProgramming.moves = true;
        _subtituloProgramming.velocity.y = -10;
        _subtituloProgramming.alignment = CENTER;

        _textoAutorProgramming = new FlxText(0,0,0, "@jonnrauber");
        _textoAutorProgramming.antialiasing = true;
        _textoAutorProgramming.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xffffffff);
        _textoAutorProgramming.screenCenter();
        _textoAutorProgramming.y = _subtituloProgramming.y + _subtituloProgramming.height + 15;
        _textoAutorProgramming.moves = true;
        _textoAutorProgramming.velocity.y = -10;
        _textoAutorProgramming.alignment = CENTER;

        _subtituloArt = new FlxText(0,0,0, "[Art]");
        _subtituloArt.antialiasing = true;
        _subtituloArt.setFormat(AssetPaths.Quicksand_Regular__ttf, 16, 0xff00ff00);
        _subtituloArt.screenCenter();
        _subtituloArt.y = _textoAutorProgramming.y + _textoAutorProgramming.height + 20;
        _subtituloArt.moves = true;
        _subtituloArt.velocity.y = -10;
        _subtituloArt.alignment = CENTER;

        _textoAutorArt = new FlxText(0,0,0, "");
        _textoAutorArt.text += "Boss and Programmer sprites by Sithjester\n(untamed.wild-refuge.net/rmxpresources)";
        _textoAutorArt.text += "\n\nButtons and interface by @jonnrauber";
        _textoAutorArt.text += "\n\nCaveat & Quicksand fonts by Google Fonts";
        _textoAutorArt.text += "\n\nSpacebar key icon by orioniconlibrary.com";
        _textoAutorArt.text += "\n\nRight & Left mouse click icon by 8icons.com";
        _textoAutorArt.text += "\n\nInterior tileset 16x16 by Bonsaiheldin\n(opengameart.org/content/interior-tileset-16x16)";
        _textoAutorArt.text += "\n\nOffice tileset by no2games\n(opengameart.org/content/office-space-tileset)";
        _textoAutorArt.text += "\n\nEB's office tileset by GrandmaDeb on RPGMakerWeb";
        _textoAutorArt.antialiasing = true;
        _textoAutorArt.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xffffffff);
        _textoAutorArt.screenCenter();
        _textoAutorArt.y = _subtituloArt.y + _subtituloArt.height + 15;
        _textoAutorArt.moves = true;
        _textoAutorArt.velocity.y = -10;
        _textoAutorArt.alignment = CENTER;

        _spriteHaxeFlixel = new FlxSprite();
        _spriteHaxeFlixel.antialiasing = true;
        _textoHaxeFlixel = new FlxText(0,0,0, "Powered by HaxeFlixel");
        _textoHaxeFlixel.setFormat(AssetPaths.Quicksand_Bold__ttf, 14, 0xff666666);
        _textoHaxeFlixel.x = (FlxG.width - _textoHaxeFlixel.width - _spriteHaxeFlixel.width)/2.;
        _textoHaxeFlixel.y = _textoAutorArt.y + _textoAutorArt.height + 20;
        _textoHaxeFlixel.moves = true;
        _textoHaxeFlixel.velocity.y = -10;
        _textoHaxeFlixel.alignment = CENTER;
        
        _spriteHaxeFlixel.x = _textoHaxeFlixel.x + _textoHaxeFlixel.width + 5;
        _spriteHaxeFlixel.y = _textoHaxeFlixel.y;
        _spriteHaxeFlixel.velocity.y = -10;

        _btnVoltar = new FlxButton(0, 0, "Back", goMenu);
        _btnVoltar.label.setFormat(AssetPaths.Quicksand_Regular__ttf, 14, 0xff000000);
		_btnVoltar.loadGraphic(AssetPaths.generic_button__png, true, 176, 30);
        _btnVoltar.x = FlxG.width - _btnVoltar.width - 10;
        _btnVoltar.y = FlxG.height - _btnVoltar.height - 10;

        add(_titulo);
        add(_subtituloProgramming);
        add(_subtituloArt);
        add(_textoAutorProgramming);
        add(_textoAutorArt);
        add(_textoHaxeFlixel);
        add(_spriteHaxeFlixel);
        add(_btnVoltar);
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