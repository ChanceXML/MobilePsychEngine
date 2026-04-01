package android.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;

class FlxButton extends FlxSprite
{
	public var onDown:Void->Void;
	public var onUp:Void->Void;
	public var onPressed:Void->Void;

	public var pressed(default, null):Bool = false;
	public var justPressed(default, null):Bool = false;
	public var justReleased(default, null):Bool = false;

	public function new(x:Float = 0, y:Float = 0, ?onClick:Void->Void)
	{
		super(x, y);

		loadGraphic("flixel/images/ui/button.png", true, 80, 20);
		scrollFactor.set();

		onUp = onClick;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		justPressed = false;
		justReleased = false;

		pressed = false;

		#if FLX_TOUCH
		for (touch in FlxG.touches.list)
		{
			var point = touch.getWorldPosition(null, FlxPoint.weak());

			if (overlapsPoint(point))
			{
				if (touch.justPressed)
				{
					justPressed = true;
					pressed = true;

					if (onDown != null)
						onDown();
				}

				if (touch.pressed)
				{
					pressed = true;

					if (onPressed != null)
						onPressed();
				}

				if (touch.justReleased)
				{
					justReleased = true;
					pressed = false;

					if (onUp != null)
						onUp();
				}
			}
		}
		#end
	}

	override public function destroy():Void
	{
		onDown = null;
		onUp = null;
		onPressed = null;
		super.destroy();
	}
}
