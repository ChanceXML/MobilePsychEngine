package android.controls;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;

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
	
	private inline static var B_W:Int = 132;
	private inline static var B_H:Int = 135;
	
	public function new(?DPad:DPadMode, ?Action:ActionMode)
	{
		super();

		switch (DPad)
		{
			case UP_DOWN:
				add(buttonUp = createButton(0, FlxG.height - 255, B_W, B_H, 'up'));
				add(buttonDown = createButton(0, FlxG.height - 135, B_W, B_H, 'down'));
			case LEFT_RIGHT:
				add(buttonLeft = createButton(0, FlxG.height - 135, B_W, B_H, 'left'));
				add(buttonRight = createButton(126, FlxG.height - 135, B_W, B_H, 'right'));
			case UP_LEFT_RIGHT:
				add(buttonUp = createButton(105, FlxG.height - 243, B_W, B_H, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 135, B_W, B_H, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 135, B_W, B_H, 'right'));
			case DOWN_LEFT_RIGHT:
				add(buttonLeft = createButton(0, FlxG.height - 243, B_W, B_H, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 243, B_W, B_H, 'right'));
				add(buttonDown = createButton(105, FlxG.height - 135, B_W, B_H, 'down'));	
			case FULL:
				add(buttonUp = createButton(105, FlxG.height - 348, B_W, B_H, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 243, B_W, B_H, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 243, B_W, B_H, 'right'));
				add(buttonDown = createButton(105, FlxG.height - 135, B_W, B_H, 'down'));
			case RIGHT_FULL:
				add(buttonUp = createButton(FlxG.width - 258, FlxG.height - 414, B_W, B_H, 'up'));
				add(buttonLeft = createButton(FlxG.width - 390, FlxG.height - 309, B_W, B_H, 'left'));
				add(buttonRight = createButton(FlxG.width - 132, FlxG.height - 309, B_W, B_H, 'right'));
				add(buttonDown = createButton(FlxG.width - 258, FlxG.height - 201, B_W, B_H, 'down'));
			case NONE:
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
			case X:
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'x'));
			case Y:
				add(buttonY = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'y'));
			case C:
				add(buttonC = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'c'));
			case A_B:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
			case A_C:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonC = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'c'));
			case A_X:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonX = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'x'));
			case A_Y:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'y'));
			case A_B_C:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonC = createButton(FlxG.width - 381, FlxG.height - 135, B_W, B_H, 'c'));
			case A_X_Y:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 381, FlxG.height - 135, B_W, B_H, 'x'));				
			case A_B_X_Y:
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 255, B_W, B_H, 'x'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
			case A_B_C_X_Y:
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 255, B_W, B_H, 'x'));
				add(buttonC = createButton(FlxG.width - 381, FlxG.height - 135, B_W, B_H, 'c'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
			case NONE:
			case B_C:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonC = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'c'));
			case B_X:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonX = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'x'));
			case B_Y:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'y'));			
			case B_X_Y:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'b'));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 381, FlxG.height - 135, B_W, B_H, 'x'));
			case B_C_X_Y:
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 255, B_W, B_H, 'x'));
				add(buttonC = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'c'));
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'b'));
			case A_C_X_Y:
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, B_W, B_H, 'y'));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 255, B_W, B_H, 'x'));
				add(buttonC = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'c'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));	
			default:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, B_W, B_H, 'a'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, B_W, B_H, 'b'));
		}

		scrollFactor.set();
	}

	override function destroy()
	{
		super.destroy();

		var buttons:Array<FlxButton> = [buttonA, buttonB, buttonC, buttonX, buttonY, buttonLeft, buttonUp, buttonRight, buttonDown];
		for (btn in buttons)
		{
			if (btn != null) btn.destroy();
		}

		buttonA = buttonB = buttonC = buttonX = buttonY = buttonLeft = buttonDown = buttonUp = buttonRight = null;
	}
	
	private function createButton(x:Float, y:Float, width:Int, height:Int, graphic:String):FlxButton
	{
		var button:FlxButton = new FlxButton(x, y);
		
		var frames = FlxAtlasFrames.fromSpriteSheetPacker(
			'assets/shared/images/mobile/controls/classic/virtual-input-classic.png', 
			'assets/shared/images/mobile/controls/classic/virtual-input-classic.txt'
		);
		
		button.frames = FlxTileFrames.fromFrame(frames.getByName(graphic), FlxPoint.get(width, height));
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
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
	X;
	Y;
	C;
	A_B;
	A_C;
	A_X;
	A_Y;
	A_B_C;
	A_X_Y;
	A_B_X_Y;
	A_C_X_Y;
	A_B_C_X_Y;
	B_C;
	B_X;
	B_Y;
	B_C_X_Y;
	B_X_Y;
}
