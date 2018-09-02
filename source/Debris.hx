package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Debris extends FlxSprite {

  var maxSpeed:Int = 250;
  var angSpeed:Float = 0;
  var size:Int = 0;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
    size = Std.random(10) + 4;
    makeGraphic(size, size, FlxColor.fromRGB(200, 200, 200));
    velocity.set(Std.random(maxSpeed), Std.random(maxSpeed));
    this.angle = Std.random(90);
    this.angSpeed = Std.random(20)/20 - 0.5;
  }

  override public function update(elapsed:Float):Void {
    FlxSpriteUtil.screenWrap(this);
    if (Std.random(200) == 1) this.exists = false;
    this.angle += this.angSpeed;
    super.update(elapsed);
  }

}
