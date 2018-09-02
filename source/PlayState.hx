package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxVelocity;

class PlayState extends FlxState {

	var _player:Player = null;

	override public function create():Void {
		FlxG.mouse.visible = false;
		_player = new Player(20, 20);
		add(_player);
		var _hud:Hud = new Hud(_player);
		add(_hud);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		spawn();
		super.update(elapsed);
	}

	public function spawn():Void {
		if (Std.random(120) == 1) {
			var _asteroid = new Asteroid(0, 0);
			add(_asteroid);
		}
	}
}
