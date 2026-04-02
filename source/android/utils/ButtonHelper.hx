package android.utils;

#if mobile
import android.controls.VirtualPad;
import StringTools;
#end

class ButtonHelper
{
	#if mobile

	public static function create(parent:Dynamic, dpad:Dynamic, action:Dynamic):VirtualPad
	{
		var vpad = new VirtualPad(dpad, action);
		if (parent != null) parent.add(vpad);
		return vpad;
	}

	public static function bind(vpad:VirtualPad, dpad:Array<String>, actions:Array<String>):Void
	{
		if (vpad == null) return;

		// ---- DPAD BINDING ---- //
		if (dpad != null)
		{
			var up    = dpad.length > 0 ? dpad[0] : null;
			var down  = dpad.length > 1 ? dpad[1] : null;
			var left  = dpad.length > 2 ? dpad[2] : null;
			var right = dpad.length > 3 ? dpad[3] : null;

			vpad.bindDPad(up, down, left, right);

			// mirror (ui_ <-> note_)
			var mup = (up != null && StringTools.startsWith(up, "note_")) ? StringTools.replace(up, "note_", "ui_")
			         : (up != null && StringTools.startsWith(up, "ui_")) ? StringTools.replace(up, "ui_", "note_") : null;

			var mdown = (down != null && StringTools.startsWith(down, "note_")) ? StringTools.replace(down, "note_", "ui_")
			           : (down != null && StringTools.startsWith(down, "ui_")) ? StringTools.replace(down, "ui_", "note_") : null;

			var mleft = (left != null && StringTools.startsWith(left, "note_")) ? StringTools.replace(left, "note_", "ui_")
			           : (left != null && StringTools.startsWith(left, "ui_")) ? StringTools.replace(left, "ui_", "note_") : null;

			var mright = (right != null && StringTools.startsWith(right, "note_")) ? StringTools.replace(right, "note_", "ui_")
			            : (right != null && StringTools.startsWith(right, "ui_")) ? StringTools.replace(right, "ui_", "note_") : null;

			vpad.bindDPad(mup, mdown, mleft, mright);
		}

		// ---- ACTION BUTTONS ---- //
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
