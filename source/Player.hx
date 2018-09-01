package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite {
  public function new(?X:Float=0, ?Y:Float=0) {
    makeGraphic(16, 16, FlxColor.BLUE);
    super(X, Y);
  }
}
