package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.system.FlxSound;
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
	var spawnMax:Int = 10;
	var spawnMin:Int = 3;
	var spawnCount:Int = 0;
	var smashSound:FlxSound = null;
	var hitSound:FlxSound = null;

	override public function create():Void {
		FlxG.mouse.visible = false;
		_player = new Player(Std.int(FlxG.width/2), Std.int(FlxG.height/2));
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
		smashSound = FlxG.sound.load("assets/sounds/smash.wav");
		hitSound = FlxG.sound.load("assets/sounds/hit.wav");
		super.create();
	}

	override public function update(elapsed:Float):Void {
		if (spawnCount < spawnMax) spawn();
		super.update(elapsed);
		FlxG.overlap(_player, _asteroids, smash);
		FlxG.collide(_asteroids, _asteroids, hit);
		updateEffect();
		if (FlxG.keys.pressed.ESCAPE) FlxG.resetState();
	}

	public function spawn():Void {
		if (Std.random(120) == 1 || spawnCount < spawnMin) {
			var _asteroid = new Asteroid(0, 0);
			_asteroids.add(_asteroid);
			add(_asteroid);
			spawnCount += 1;
		}
	}

	public function hit(Asteroid:FlxObject, Asteroid:FlxObject):Void {
		hitSound.play();
	}

	public function smash(Player:FlxObject, Asteroid:FlxObject):Void {
		var playerVelocity:FlxPoint = Player.velocity;
		var asteroidVelocity:FlxPoint = Asteroid.velocity;
		var xDelta = Math.abs(playerVelocity.x - asteroidVelocity.x);
		var yDelta = Math.abs(playerVelocity.y - asteroidVelocity.y);
		var delta = Math.sqrt(xDelta * xDelta + yDelta * yDelta);
		var quantity:Int = Std.random(20) + 20;
		var i:Int = 0;
		if (delta > _player.smashLimit) {
			Asteroid.exists = false;
			spawnCount -= 1;
			_player.fuel += quantity;
			if (_player.fuel > 100) _player.fuel = 100;
			_player.score += 1;
			_shake.start();
			smashSound.play();
			for (i in 0...Std.random(5) + 5) {
				var _debris:Debris = new Debris(_player.x, _player.y);
				add(_debris);
			}
		} else hit(null, null);
		_player.hSpeed = _player.hSpeed * 0.1;
		_player.vSpeed = _player.vSpeed * 0.1;
		FlxG.collide(_player, _asteroids);
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
