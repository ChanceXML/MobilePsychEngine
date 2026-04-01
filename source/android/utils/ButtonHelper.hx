package android.utils;

#if mobile
import android.controls.VirtualPad;
import flixel.group.FlxGroup;
#end

class ButtonHelper
{
	#if mobile

	public static function create(parent:FlxGroup):VirtualPad
	{
		var pad = new VirtualPad();
		parent.add(pad);
		return pad;
	}

	public static function bind(pad:VirtualPad, dpad:Array<String>, actions:Array<String>):Void
	{
		if (pad == null) return;

		if (dpad != null && dpad.length >= 4)
		{
			pad.addButton(105, 300, dpad[0], "up", 396, 135);
			pad.addButton(0, 420, dpad[1], "left", 396, 135);
			pad.addButton(207, 420, dpad[2], "right", 396, 135);
			pad.addButton(105, 540, dpad[3], "down", 396, 135);
		}

		if (actions != null)
		{
			if (actions.length > 0)
				pad.addButton(1000, 420, actions[0], "a", 396, 135);
			if (actions.length > 1)
				pad.addButton(1150, 420, actions[1], "b", 396, 135);
			if (actions.length > 2)
				pad.addButton(1000, 300, actions[2], "x", 396, 135);
			if (actions.length > 3)
				pad.addButton(1150, 300, actions[3], "y", 396, 135);
		}
	}

	#end
}
