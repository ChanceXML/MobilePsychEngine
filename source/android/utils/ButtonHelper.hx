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

		if (dpad != null)
      {
            var up    = dpad.length > 0 ? dpad[0] : null;
            var down  = dpad.length > 1 ? dpad[1] : null;
            var left  = dpad.length > 2 ? dpad[2] : null;
            var right = dpad.length > 3 ? dpad[3] : null;

            vpad.bindDPad(up, down, left, right);
		  
			var mirrorDPad = new Array<String>();
			for (i in 0...4) {
				var act = dpad[i];
				if (act != null) {
					if (StringTools.startsWith(act, "note_")) 
						mirrorDPad.push(StringTools.replace(act, "note_", "ui_"));
					else if (StringTools.startsWith(act, "ui_")) 
						mirrorDPad.push(StringTools.replace(act, "ui_", "note_"));
					else 
						mirrorDPad.push("");
				} else {
					mirrorDPad.push("");
				}
			}
			
			vpad.bindDPad(mirrorDPad[0], mirrorDPad[1], mirrorDPad[2], mirrorDPad[3]);
		}

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
