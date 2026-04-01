package android.utils;

#if mobile
import android.controls.VirtualPad;
import flixel.group.FlxGroup;
#end

class ButtonHelper
{
	#if mobile

	public static function create(parent:FlxGroup, ?dpad:Dynamic = null, ?action:Dynamic = null):VirtualPad
	{
		var pad = new VirtualPad(dpad, action);
		parent.add(pad);
		return pad;
	}

	public static function bind(pad:VirtualPad, dpad:Array<String>, actions:Array<String>):Void
	{
		if (pad == null) return;

		if (dpad != null && dpad.length >= 4)
			pad.bindDPad(dpad[0], dpad[1], dpad[2], dpad[3]);

		if (actions != null)
		{
			switch (actions.length)
			{
				case 1: pad.bindActionGroup(actions[0]);
				case 2: pad.bindActionGroup(actions[0], actions[1]);
				case 3: pad.bindActionGroup(actions[0], actions[1], actions[2]);
				case 4: pad.bindActionGroup(actions[0], actions[1], actions[2], actions[3]);
				case 5: pad.bindActionGroup(actions[0], actions[1], actions[2], actions[3], actions[4]);
				default:
			}
		}
	}

	#end
}
