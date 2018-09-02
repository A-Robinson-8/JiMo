package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxVelocity;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite {

  public var topSpeed:Float = 1500;
  public var baseAccel:Float = 100;
  public var hSpeed:Float = 0;
  public var vSpeed:Float = 0;
  public var limit:Float = 100;
  public var friction:Float = 0.99;
  public var position:FlxPoint = null;
  public var mousePosition:FlxPoint = null;
  public var fuel:Float = 100;
  public var fuelEfficiency:Float = 0.5;
  public var smashLimit:Int = 1000;
  public var scoreTemp:Int = 0;
  public var score:Int = 0;
  public var multiplier:Int = 100;
  public var thrust:FlxSound = null;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
    loadGraphic("assets/images/ship.png");
    thrust = FlxG.sound.load("assets/sounds/thrust.wav");
    thrust.volume = 0.3;
  }

  override public function update(elapsed:Float):Void {
    position = updatePosition();
    mousePosition = FlxG.mouse.getWorldPosition();
    if (FlxG.mouse.pressed) this.move();
    hSpeed = hSpeed * friction;
    vSpeed = vSpeed * friction;
    velocity.set(hSpeed, vSpeed);
    super.update(elapsed);
    angle = position.angleBetween(mousePosition);
  	FlxSpriteUtil.screenWrap(this);
    if (FlxG.mouse.justReleased) this.calcScore();
  }

  public function move():Void {
    if (fuel != 0) {
      multiplier += 1;
      var hDelta:Float = Math.abs(mousePosition.x - position.x);
      var vDelta:Float = Math.abs(mousePosition.y - position.y);
      var hSpeedOld:Float = hSpeed;
      var vSpeedOld:Float = vSpeed;
      if (position.distanceTo(mousePosition) > limit) {
        if (position.x < mousePosition.x && hDelta > limit) hSpeed += baseAccel;
        else if (hDelta > limit) hSpeed -= baseAccel;
        if (position.y < mousePosition.y && vDelta > limit) vSpeed += baseAccel;
        else if (vDelta > limit) vSpeed -= baseAccel;
      }
      if (hSpeed != hSpeedOld || vSpeed != vSpeedOld) fuel -= fuelEfficiency;
      if (hSpeed > topSpeed) hSpeed = topSpeed;
      if (vSpeed > topSpeed) vSpeed = topSpeed;
      velocity.set(hSpeed, vSpeed);
      thrust.play();
    }
  }

  public function updatePosition():FlxPoint {
    return new FlxPoint(this.x, this.y);
  }

  public function calcScore():Void {
    score += Std.int(scoreTemp * multiplier / 100);
    scoreTemp = 0;
    multiplier = 100;
  }
}
