package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxVelocity;
import flixel.group.FlxGroup;

class PlayState extends FlxState {

	var _player:Player = null;
	var _hud:Hud = null;
	var _asteroids:FlxGroup = null;

	override public function create():Void {
		FlxG.mouse.visible = false;
		_player = new Player(20, 20);
		add(_player);
		_hud = new Hud(_player);
		add(_hud);
		_asteroids = new FlxGroup();
		add(_asteroids);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		spawn();
		super.update(elapsed);
	}

	public function spawn():Void {
		if (Std.random(120) == 1) {
			var _asteroid = new Asteroid(0, 0);
			_asteroids.add(_asteroid);
			add(_asteroid);
		}
	}
}
