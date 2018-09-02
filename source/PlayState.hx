package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.math.FlxPoint;
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
		FlxG.collide(_player, _asteroids, smash);
	}

	public function spawn():Void {
		if (Std.random(120) == 1) {
			var _asteroid = new Asteroid(0, 0);
			_asteroids.add(_asteroid);
			add(_asteroid);
		}
	}

	public function smash(Player:FlxObject, Asteroid:FlxObject):Void {
		var playerVelocity:FlxPoint = Player.velocity;
		var asteroidVelocity:FlxPoint = Asteroid.velocity;
		var xDelta = Math.abs(playerVelocity.x - asteroidVelocity.x);
		var yDelta = Math.abs(playerVelocity.y - asteroidVelocity.y);
		var delta = Math.sqrt(xDelta * xDelta + yDelta * yDelta);
		if (delta > _player.smashLimit) {
			Asteroid.exists = false;
			_player.fuel += Std.random(20) + 20;
			if (_player.fuel > 100) _player.fuel = 100;
		}
	}
}
