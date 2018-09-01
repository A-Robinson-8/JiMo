package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class Spawner extends FlxSprite {

  var rnd:Int = 0;
  var _asteroid = null;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
  }

  override public function update(elapsed:Float):Void {
    spawn();
    super.update(elapsed);
  }

  public function spawn() {
    rnd = Std.random(120);
    if (rnd == 1) {
      _asteroid = new Asteroid();
      add(_asteroid);
    }
  }
}
