package android.utils;

#if mobile
import android.controls.VirtualPad;
import flixel.FlxBasic;
import flixel.group.FlxGroup;
#end

class ButtonHelper
{
	#if mobile

	public static function create(parent:FlxBasic, dpad:DPadMode, action:ActionMode):VirtualPad
	{
		if (parent == null) return null;

		var vpad = new VirtualPad(dpad, action);
		
		if (Std.isOfType(parent, FlxGroup))
		{
			cast(parent, FlxGroup).add(vpad);
		}

		return vpad;
	}

	public static function bind(vpad:VirtualPad, dpad:Array<String>, actions:Array<String>):Void
	{
		if (vpad == null) return;

		if (dpad != null && dpad.length >= 4)
			vpad.bindDPad(dpad[0], dpad[1], dpad[2], dpad[3]);

		if (actions != null)
		{
			switch (actions.length)
			{
				case 1: vpad.bindActionGroup(actions[0]);
				case 2: vpad.bindActionGroup(actions[0], actions[1]);
				case 3: vpad.bindActionGroup(actions[0], actions[1], actions[2]);
				case 4: vpad.bindActionGroup(actions[0], actions[1], actions[2], actions[3]);
				case 5: vpad.bindActionGroup(actions[0], actions[1], actions[2], actions[3], actions[4]);
			}
		}
	}

	#end
}				
