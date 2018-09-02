package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.group.FlxGroup;
import flixel.addons.effects.chainable.FlxShakeEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;

class PlayState extends FlxState {

	var _player:Player = null;
	var _hud:Hud = null;
	var _asteroids:FlxGroup = null;
	var _shake:FlxShakeEffect = null;
	var _effectSprite:FlxEffectSprite = null;

	override public function create():Void {
		FlxG.mouse.visible = false;
		_player = new Player(20, 20);
		add(_player);
		_hud = new Hud(_player);
		add(_hud);
		_asteroids = new FlxGroup();
		add(_asteroids);
		_shake = new FlxShakeEffect(5, 0.2);
		_effectSprite = new FlxEffectSprite(_player);
		add(_effectSprite);
		_effectSprite.effects = [_shake];
		makeStars();
		super.create();
	}

	override public function update(elapsed:Float):Void {
		spawn();
		super.update(elapsed);
		FlxG.collide(_player, _asteroids, smash);
		FlxG.collide(_asteroids, _asteroids);
		updateEffect();
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
			_shake.start();
		}
	}

	public function updateEffect():Void {
		_effectSprite.x = _player.x;
		_effectSprite.y = _player.y;
		_effectSprite.angle = _player.angle;
	}

	public function makeStars():Void {
		var i = 0;
		for (i in 0...Std.random(40) + 20) {
			var _star = new Star(Std.random(FlxG.width), Std.random(FlxG.height));
			add(_star);
		}
	}
}
