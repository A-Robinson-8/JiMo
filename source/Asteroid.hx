package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Asteroid extends FlxSprite {

  var maxSpeed:Int = 250;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
    makeGraphic(16, 16, FlxColor.WHITE);
    velocity.set(Std.random(maxSpeed), Std.random(maxSpeed));
  }

  override public function update(elapsed:Float):Void {
    FlxSpriteUtil.screenWrap(this);
    super.update(elapsed);
  }

}
