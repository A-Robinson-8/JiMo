package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
using flixel.util.FlxSpriteUtil;

class Hud extends FlxTypedGroup<FlxSprite> {

  var fuelBarTop:FlxBar = null;
  var fuelBarBtm:FlxBar = null;
  var fuelBarLft:FlxBar = null;
  var fuelBarRgt:FlxBar = null;
  var text:FlxText = null;
  var multi:FlxText = null;
  var p:Player = null;

  public function new(p:Player) {
    super();
    this.p = p;
    fuelBarTop = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, FlxG.width, 20);
		fuelBarTop.createFilledBar(FlxColor.TRANSPARENT, FlxColor.WHITE, false);
		add(fuelBarTop);
    fuelBarTop.active = true;
    fuelBarBtm = new FlxBar(0, FlxG.height - 20, FlxBarFillDirection.RIGHT_TO_LEFT, FlxG.width, 20);
		fuelBarBtm.createFilledBar(FlxColor.TRANSPARENT, FlxColor.WHITE, false);
		add(fuelBarBtm);
    fuelBarBtm.active = true;
    fuelBarLft = new FlxBar(0, 0, FlxBarFillDirection.BOTTOM_TO_TOP, 20, FlxG.height);
		fuelBarLft.createFilledBar(FlxColor.TRANSPARENT, FlxColor.WHITE, false);
		add(fuelBarLft);
    fuelBarLft.active = true;
    fuelBarRgt = new FlxBar(FlxG.width - 20, 0, FlxBarFillDirection.TOP_TO_BOTTOM, 20, FlxG.height);
		fuelBarRgt.createFilledBar(FlxColor.TRANSPARENT, FlxColor.WHITE, false);
	  add(fuelBarRgt);
    fuelBarRgt.active = true;
    visible = true;
    text = new FlxText(20, FlxG.height - 23);
    text.setFormat("assets/data/VT323-Regular.ttf", 20);
    add(text);

  }

  override public function update(elapsed:Float):Void {
    fuelBarTop.value = p.fuel;
    fuelBarBtm.value = p.fuel;
    fuelBarLft.value = p.fuel;
    fuelBarRgt.value = p.fuel;
    text.text = "SMASHTEROIDS | SCORE: " + p.score + " | CHAIN: " + p.scoreTemp + " | MULTI: x" + p.multiplier / 100 + " | R TO RESET";
    super.update(elapsed);
  }

}
