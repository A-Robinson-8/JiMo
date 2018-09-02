package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
using flixel.util.FlxSpriteUtil;

class Star extends FlxSprite {

  var size:Int = null;

  public function new(?X:Float=0, ?Y:Float=0) {
    super(X, Y);
    this.size = Std.random(5) + 1;
    this.angle = Std.random(90);
    makeGraphic(size, size, FlxColor.WHITE);
  }

}
