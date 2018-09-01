package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
using flixel.util.FlxSpriteUtil;

class Hud extends FlxTypedGroup<FlxSprite> {

  var fuelBar:FlxBar = null;

  public function new() {
    super();
    fuelBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 960, 10);
		fuelBar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.WHITE, false);
		add(fuelBar);
    fuelBar.value = 100;
    fuelBar.active = true;
    visible = true;
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }

}
