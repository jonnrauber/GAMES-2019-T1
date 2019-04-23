package;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var _postOffice:PostOffice;
	var _boss:Boss;
	var _programmers:FlxTypedGroup<Programmer>;

	var _navigationMap:FlxTilemap;
	var _floorMap:FlxTilemap;
	var _wallMap:FlxTilemap;
	var _tablesMap:FlxTilemap;
	var _frontChairsMap:FlxTilemap;

	override public function create():Void
	{
		_postOffice = new PostOffice();

		_boss = new Boss();
		_boss.makeGraphic(20, 20, 0xffff0000);
		_boss.x = 80 - _boss.width/2;
		_boss.y = 414 - _boss.height/2;
		_boss.path = new FlxPath();

		this.initializeMaps();
		this.initializeProgrammers();

		add(_navigationMap);
		add(_postOffice);
		add(_floorMap);
		add(_wallMap);
		add(_tablesMap);
		add(_frontChairsMap);
		add(_boss);
		add(_programmers);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed) {
			var pathPoints:Array<FlxPoint> = _navigationMap.findPath(
					FlxPoint.get(_boss.x + _boss.width/2, _boss.y + _boss.height/2),
					FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y));

			if (pathPoints != null) {
				_boss.path.start(pathPoints, 100, FlxPath.FORWARD);	
			}
		}

		//If Boss collides to Programmer, Boss demands to Programmer to go work
		for (p in _programmers) {
			if (FlxG.overlap(_boss, p)) {
				var m:Message = new Message();
				m.from = _boss;
				m.to = p;
				m.op = Message.OP_GO_WORK;
				m.data = 2;
				_postOffice.send(m);
			}
		}
	}

	function initializeProgrammers():Void {
		_programmers = new FlxTypedGroup<Programmer>();

		var p1:Programmer = new Programmer();
		p1.setWorkLocation(80, 192);
		_programmers.add(p1);

		var p2:Programmer = new Programmer();
		p2.setWorkLocation(160, 192);
		_programmers.add(p2);

		var p3:Programmer = new Programmer();
		p3.setWorkLocation(272, 192);
		_programmers.add(p3);

		var p4:Programmer = new Programmer();
		p4.setWorkLocation(352, 192);
		_programmers.add(p4);

		var p5:Programmer = new Programmer();
		p5.setWorkLocation(464, 192);
		_programmers.add(p5);

		var p6:Programmer = new Programmer();
		p6.setWorkLocation(544, 192);
		_programmers.add(p6);

		var p7:Programmer = new Programmer();
		p7.setWorkLocation(160, 414);
		_programmers.add(p7);
	}

	function initializeMaps():Void {
		_navigationMap = new FlxTilemap();
		_navigationMap.loadMapFromCSV("assets/data/map_navmesh.csv", "assets/images/tileset_interior.png", 16, 16, 0, 1);

		_floorMap = new FlxTilemap();
		_floorMap.loadMapFromCSV("assets/data/map_chao.csv", "assets/images/tileset_interior.png", 16, 16, 0, 1);

		_wallMap = new FlxTilemap();
		_wallMap.loadMapFromCSV("assets/data/map_parede.csv", "assets/images/tileset_office.png", 16, 16, 0, 1);

		_tablesMap = new FlxTilemap();
		_tablesMap.loadMapFromCSV("assets/data/map_mesas.csv", "assets/images/tileset_interior.png", 16, 16, 0, 1);

		_frontChairsMap = new FlxTilemap();
		_frontChairsMap.loadMapFromCSV("assets/data/map_cadeiras_frente.csv", "assets/images/tileset_pc.png", 16, 16, 0, 1);
	}
}
