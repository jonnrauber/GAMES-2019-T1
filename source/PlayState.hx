package;

import flixel.math.FlxVector;
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
	var _warnings:FlxTypedGroup<Warning>;

	var _navigationMap:FlxTilemap;
	var _floorMap:FlxTilemap;
	var _wallMap:FlxTilemap;
	var _tablesMap:FlxTilemap;
	var _frontChairsMap:FlxTilemap;

	override public function create():Void
	{
		_postOffice = new PostOffice();

		_boss = new Boss();
		_boss.x = 80 - _boss.width/2;
		_boss.y = 414 - _boss.height/2;
		_boss.path = new FlxPath();

		this.initializeMaps();
		this.initializeProgrammers();
		this.initializeWarnings();

		add(_navigationMap);
		add(_postOffice);
		add(_floorMap);
		add(_wallMap);
		add(_tablesMap);
		add(_frontChairsMap);
		add(_programmers);
		add(_boss);
		add(_warnings);
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

		if (FlxG.mouse.justPressedRight) {
			var w = _warnings.getFirstAvailable();
			if (w != null) {
				w.reset(_boss.x + (_boss.width + w.width)/2,
					_boss.y + (_boss.height + w.height)/2);

				var vel:FlxVector = new FlxVector(FlxG.mouse.x - w.x, FlxG.mouse.y - w.y);
				vel.normalize();
				vel.scale(300);

				w.velocity.x = vel.x;
				w.velocity.y = vel.y;
			}
		}

		if (FlxG.keys.pressed.SPACE) {
		//If Boss collides to Programmer, Boss demands to Programmer to go work
			for (p in _programmers) {
				if (FlxG.overlap(_boss, p) && p._state != Programmer.WORKING_STATE) {
					var m:Message = new Message(_boss, p, Message.OP_GO_WORK);
					_postOffice.send(m);
				}
				
			}
		}

		FlxG.overlap(_warnings, _programmers, onOverlapWarning);
	}

	function onOverlapWarning(w:Entity, p:Entity):Void {
		var m:Message = new Message(w, p, Message.OP_GO_WORK);
		_postOffice.send(m);
		w.kill();
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
	
	function initializeWarnings():Void {
		_warnings = new FlxTypedGroup<Warning>();
        for (i in 0...3) {
            var w = new Warning();
            _warnings.add(w);
        }
	}
}
