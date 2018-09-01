package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxVelocity;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite {

  public var topSpeed:Float = 750;
  public var baseAccel:Float = 0.1;
  public var hSpeed:Float = 0;
  public var vSpeed:Float = 0;
  public var limit:Float = 10;
  public var friction:Float = 0.95;
  public var position:FlxPoint = null;
  public var mousePosition:FlxPoint = null;
  public var distance:Float = null;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
    loadGraphic("assets/images/ship.png");
    drag.x = drag.y = friction;
  }

  override public function update(elapsed:Float):Void {
    move();
    super.update(elapsed);
  }

  public function move():Void {

    position = updatePosition();
    mousePosition = FlxG.mouse.getWorldPosition();
    distance = position.distanceTo(mousePosition);

    if (distance > limit) {
      if (position.x < mousePosition.x) hSpeed += baseAccel * distance;
      else hSpeed -= baseAccel * distance;
      if (position.y < mousePosition.y) vSpeed += baseAccel * distance;
      else vSpeed -= baseAccel * distance;
    }

    hSpeed = hSpeed * friction;
    vSpeed = vSpeed * friction;
    if (hSpeed > topSpeed) hSpeed = topSpeed;
    if (vSpeed > topSpeed) vSpeed = topSpeed;

    this.angle = position.angleBetween(mousePosition);
    velocity.set(hSpeed, vSpeed);

  }

  public function updatePosition():FlxPoint {
    return new FlxPoint(this.x, this.y);
  }
}
