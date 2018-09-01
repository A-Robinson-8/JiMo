package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxVelocity;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite {

  public var topSpeed:Float = 500;
  public var topAccel:Float = 20;
  public var hSpeed:Float = 0;
  public var vSpeed:Float = 0;
  public var limit:Float = 20;
  public var friction:Float = 2000;
  public var position:FlxPoint = null;
  public var mousePosition:FlxPoint = null;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
    makeGraphic(16, 16, FlxColor.WHITE);
    drag.x = drag.y = friction;
  }

  override public function update(elapsed:Float):Void {
    move();
    super.update(elapsed);
  }

  public function move():Void {

    position = updatePosition();
    mousePosition = FlxG.mouse.getWorldPosition();

    if (position.distanceTo(mousePosition) > limit) {
      if (position.x < mousePosition.x) hSpeed += topAccel;
      else hSpeed -= topAccel;
      if (position.y < mousePosition.y) vSpeed += topAccel;
      else vSpeed -= topAccel;
    } else {
      hSpeed = 0;
      vSpeed = 0;
    } velocity.set(hSpeed, vSpeed);
  }

  public function updatePosition():FlxPoint {
    return new FlxPoint(this.x, this.y);
  }
}
