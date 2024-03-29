package;

import flixel.math.FlxVector;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var _postOffice:PostOffice;

	var _boss:Boss;
	var _programmers:FlxTypedGroup<Programmer>;
	var _warnings:FlxTypedGroup<Warning>;
	public static var _coffeePoints:FlxTypedGroup<CoffeePoint>;

	var _HUD:HUD;

	var _productivity:Int;
	public var _gameTime:FlxTimer;

	var _navigationMap:FlxTilemap;
	var _floorMap:FlxTilemap;
	var _wallMap:FlxTilemap;
	var _tablesMap:FlxTilemap;
	var _coffeeMap:FlxTilemap;
	var _frontChairsMap:FlxTilemap;
	var _curtainsMap:FlxTilemap;

	var _gameOverSubState:GameOverSubState;

	override public function create():Void
	{
		var preGameSubState = new PreGameSubState(0xEE000000);
		preGameSubState.closeCallback = startTimer;
		openSubState(preGameSubState);

		_gameTime = new FlxTimer().start(Math.POSITIVE_INFINITY);
		_gameTime.active = false;
		_productivity = 1000;

		_postOffice = new PostOffice();
		_HUD = new HUD();

		_boss = new Boss();
		_boss.x = 80 - _boss.width/2;
		_boss.y = 414 - _boss.height/2;
		_boss.path = new FlxPath();

		this.initializeMaps();
		this.initializeProgrammers();
		this.initializeWarnings();
		this.initializeCoffeePoints();

		_gameOverSubState = new GameOverSubState(0xBB000000);

		add(_postOffice);
		add(_programmers);
		add(_boss);
		add(_warnings);
		add(_HUD);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		/* -- Mouse events 
		 * Left click: moves boss
		 * Right click: throws warning 
		 */
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
				vel.scale(100);

				w.acceleration.x = vel.x;
				w.acceleration.y = vel.y;

				vel.scale(5);

				w.velocity.x = vel.x;
				w.velocity.y = vel.y;

			}
		}

		/* -- Keyboard event
		 * ESC: pause game
		 * Space: tell to programmer to go back work
		 */
		if (FlxG.keys.justPressed.ESCAPE) {
			var pauseSubState = new PauseSubState(0x99000000);
			pauseSubState.openCallback = pauseTimer;
			pauseSubState.closeCallback = startTimer;
			openSubState(pauseSubState);
		}

		if (FlxG.keys.pressed.SPACE) {
		//If Boss collides to Programmer, Boss demands to Programmer to go work
			FlxG.overlap(_boss, _programmers, onOverlapBoss);
		}

		FlxG.overlap(_warnings, _programmers, onOverlapWarning);

		for (p in _programmers.members) {
			switch (p._state) {
				case Programmer.COFFEE_STATE:
					this._productivity -= 3;
					break;
				case Programmer.MEMES_STATE:
					this._productivity -= 2;
					break;
			}
		}

		_HUD.updateHUD(_gameTime.elapsedTime, _productivity);

		if (this._productivity <= 0) {
			_gameOverSubState._score = _gameTime.elapsedTime*1000;
			openSubState(_gameOverSubState);
		}
	}

	function onOverlapBoss(b:Boss, p:Programmer):Void {
		if (p._state == Programmer.COFFEE_STATE || p._state == Programmer.GOING_TO_COFFEE_STATE) {
			var m:Message = new Message(_boss, p, Message.OP_GO_WORK);
			_postOffice.send(m);
		}
	}

	function onOverlapWarning(w:Warning, p:Programmer):Void {
		if (p._state == Programmer.MEMES_STATE || p._state == Programmer.GOING_TO_MEMES_STATE) {
			var m:Message = new Message(w, p, Message.OP_GO_WORK);
			_postOffice.send(m);
			w.kill();
		}
	}

	function startTimer():Void {
		_gameTime.active = true;

		for (p in _programmers.members) {
			if (p._state == Programmer.WORKING_STATE)
				p._awayTimer.active = true;

			if (p._state == Programmer.GOING_TO_MEMES_STATE)
				p._memesTimer.active = true;
		}
	}

	function pauseTimer():Void {
		_gameTime.active = false;

		for (p in _programmers.members) {
			if (p._state == Programmer.WORKING_STATE)
				p._awayTimer.active = false;
				
			if (p._state == Programmer.GOING_TO_MEMES_STATE)
				p._memesTimer.active = false;
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

	function initializeCoffeePoints():Void {
		_coffeePoints = new FlxTypedGroup<CoffeePoint>();
		var y = 260;
		while(y <= 380) {
			var cp = new CoffeePoint(550, y);	
			_coffeePoints.add(cp);
			y += 20;
		}
	}

	function initializeMaps():Void {
		_navigationMap = new FlxTilemap();
		_navigationMap.loadMapFromCSV("assets/data/map_navmesh.csv", "assets/images/tileset_interior.png", 16, 16, 0, 1);

		_floorMap = new FlxTilemap();
		_floorMap.loadMapFromCSV("assets/data/map_chao.csv", "assets/images/tileset_interior.png", 16, 16, 0, 1);

		_wallMap = new FlxTilemap();
		_wallMap.loadMapFromCSV("assets/data/map_parede.csv", "assets/images/tileset_office.png", 16, 16, 0, 1);

		_tablesMap = new FlxTilemap();
		_tablesMap.loadMapFromCSV("assets/data/map_mesas.csv", "assets/images/tileset_cafe.png", 16, 16, 0, 1);

		_frontChairsMap = new FlxTilemap();
		_frontChairsMap.loadMapFromCSV("assets/data/map_cadeiras_frente.csv", "assets/images/tileset_pc.png", 16, 16, 0, 1);

		_coffeeMap = new FlxTilemap();
		_coffeeMap.loadMapFromCSV("assets/data/map_cafe.csv", "assets/images/tileset_cafe.png", 16, 16, null, 0, 1);

		_curtainsMap = new FlxTilemap();
		_curtainsMap.loadMapFromCSV("assets/data/map_cortinas.csv", "assets/images/tileset_interior.png", 16, 16, null, 0, 1);

		add(_navigationMap);
		add(_floorMap);
		add(_wallMap);
		add(_tablesMap);
		add(_frontChairsMap);
		add(_coffeeMap);
		add(_curtainsMap);
	}
	
	function initializeWarnings():Void {
		_warnings = new FlxTypedGroup<Warning>();
        for (i in 0...3) {
            var w = new Warning();
            _warnings.add(w);
        }
	}

	public static function getAvailableCoffeePoint() {
		var cp = _coffeePoints.getFirstAlive();
		if (cp != null) {
			cp.kill();
			return cp;
		}
		return new CoffeePoint(550, 340);
	}
}
