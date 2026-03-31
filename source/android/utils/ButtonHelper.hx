package android.utils;

#if mobile
import android.controls.VirtualPad;
import flixel.group.FlxGroup;
import flixel.FlxBasic;
import backend.Controls;
#end

class ButtonHelper
{
	#if mobile
	public static function create(parent:FlxBasic, dpad:VirtualPad.DPadMode, action:VirtualPad.ActionMode):VirtualPad
	{
		var vpad = new VirtualPad(dpad, action);

		var group:FlxGroup = cast parent;
		if (group != null)
			group.add(vpad);

		Controls.virtualPad = vpad;
		return vpad;
	}

	public static function setupMenu(vpad:VirtualPad):Void
	{
		if (vpad == null) return;

		vpad.bindDPad('ui_up', 'ui_down', 'ui_left', 'ui_right');
		vpad.bindActionGroup('accept', 'back');
	}

	public static function setupGameplay(vpad:VirtualPad):Void
	{
		if (vpad == null) return;

		vpad.bindDPad('note_up', 'note_down', 'note_left', 'note_right');
		vpad.bindActionGroup('note_left', 'note_down', 'note_up', 'note_right');
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
				default:
			}
		}
	}
	#end
}
