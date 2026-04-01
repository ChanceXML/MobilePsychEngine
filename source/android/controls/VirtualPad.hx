package android.controls;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxTileFrames;
import flixel.system.FlxGraphicAsset;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;

#if mobile
import backend.Controls;
#end

class VirtualPad extends FlxSpriteGroup
{
	public var buttonA:FlxButton;
	public var buttonB:FlxButton;
	public var buttonC:FlxButton;
	public var buttonY:FlxButton;
	public var buttonX:FlxButton;
	public var buttonLeft:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonDown:FlxButton;

	public var virtualpadCamera:FlxCamera;

	private inline static var B_W:Int = 132;
	private inline static var B_H:Int = 135;

	public var boundActions:Map<FlxButton, String> = new Map();

	private static var atlasFrames:FlxAtlasFrames;

	public function new(?DPad:DPadMode, ?Action:ActionMode)
	{
		super();

		virtualpadCamera = new FlxCamera();
		virtualpadCamera.bgColor = 0x00000000;
		FlxG.cameras.add(virtualpadCamera, false);
		this.cameras = [virtualpadCamera];

		if (atlasFrames == null)
		{
			atlasFrames = FlxAtlasFrames.fromSpriteSheetPacker(
				'assets/shared/images/mobile/controls/classic/virtual-input-classic.png',
				'assets/shared/images/mobile/controls/classic/virtual-input-classic.txt'
			);
		}

		switch (DPad)
		{
			case FULL, NONE:
				add(buttonUp = createButton(105, FlxG.height - 348, B_W, B_H, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 243, B_W, B_H, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 243, B_W, B_H, 'right'));
				add(buttonDown = createButton(105, FlxG.height - 135, B_W, B_H, 'down'));

			case UP_DOWN:
				add(buttonUp = createButton(0, FlxG.height - 255, B_W, B_H, 'up'));
				add(buttonDown = createButton(0, FlxG.height - 135, B_W, B_H, 'down'));

			case LEFT_RIGHT:
				add(buttonLeft = createButton(0, FlxG.height - 135, B_W, B_H, 'left'));
				add(buttonRight = createButton(126, FlxG.height - 135, B_W, B_H, 'right'));

			case RIGHT_FULL:
				add(buttonUp = createButton(FlxG.width - 258, FlxG.height - 414, B_W, B_H, 'up'));
				add(buttonLeft = createButton(FlxG.width - 390, FlxG.height - 309, B_W, B_H, 'left'));
				add(buttonRight = createButton(FlxG.width - 132, FlxG.height - 309, B_W, B_H, 'right'));
				add(buttonDown = createButton(FlxG.width - 258, FlxG.height - 201, B_W, B_H, 'down'));

			default:
				add(buttonUp = createButton(105, FlxG.height - 348, B_W, B_H, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 243, B_W, B_H, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 243, B_W, B_H, 'right'));
				add(buttonDown = createButton(105, FlxG.height - 135, B_W, B_H, 'down'));
		}

		switch (Action)
		{
			case A:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));

			case B:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'b'));

			case A_B:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));

			case A_B_X_Y:
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 255, B_W, B_H, 'x'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));

			case NONE:
			default:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
		}

		scrollFactor.set();

		#if mobile
		Controls.virtualPad = this;
		#end
	}

	public function bindDPad(up:String, down:String, left:String, right:String):Void
	{
		if (buttonUp != null) boundActions.set(buttonUp, up);
		if (buttonDown != null) boundActions.set(buttonDown, down);
		if (buttonLeft != null) boundActions.set(buttonLeft, left);
		if (buttonRight != null) boundActions.set(buttonRight, right);
	}

	public function bindActionGroup(a:String = '', b:String = '', x:String = '', y:String = '', c:String = ''):Void
	{
		if (buttonA != null && a != '') boundActions.set(buttonA, a);
		if (buttonB != null && b != '') boundActions.set(buttonB, b);
		if (buttonX != null && x != '') boundActions.set(buttonX, x);
		if (buttonY != null && y != '') boundActions.set(buttonY, y);
		if (buttonC != null && c != '') boundActions.set(buttonC, c);
	}

	public function pressed(action:String):Bool
	{
		for (btn => act in boundActions)
			if (act == action && btn.pressed) return true;
		return false;
	}

	public function justPressed(action:String):Bool
	{
		for (btn => act in boundActions)
			if (act == action && btn.justPressed) return true;
		return false;
	}

	public function justReleased(action:String):Bool
	{
		for (btn => act in boundActions)
			if (act == action && btn.justReleased) return true;
		return false;
	}

	override function destroy()
	{
		super.destroy();

		boundActions.clear();

		#if mobile
		if (Controls.virtualPad == this)
			Controls.virtualPad = null;
		#end

		if (virtualpadCamera != null)
		{
			FlxG.cameras.remove(virtualpadCamera);
			virtualpadCamera.destroy();
			virtualpadCamera = null;
		}
	}

	private function createButton(x:Float, y:Float, width:Int, height:Int, graphic:String):FlxButton
{
	var button:FlxButton = new FlxButton(x, y);

	var frame = atlasFrames.getByName(graphic);
	if (frame == null)
	{
		trace('Missing frame: ' + graphic);
		return button;
	}

	button.loadGraphic(frame);
	button.updateHitbox();
	button.scrollFactor.set();

	return button;
   }
}

enum DPadMode
{
	NONE;
	UP_DOWN;
	LEFT_RIGHT;
	UP_LEFT_RIGHT;
	DOWN_LEFT_RIGHT;
	RIGHT_FULL;
	FULL;
}

enum ActionMode
{
	NONE;
	A;
	B;
	A_B;
	A_B_X_Y;
}
