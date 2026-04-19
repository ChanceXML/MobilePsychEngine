package backend;

#if mobile
import flixel.FlxState;
import flixel.FlxG;
import android.controls.VirtualPad;
import android.utils.ButtonHelper;
#end

class MobileInputAPI
{
	#if mobile
	public static var currentPad:VirtualPad;
	public static var currentState:FlxState;
	#end

	public static function requestPad(config:MobilePadConfig, state:FlxState):Void
	{
		#if mobile
		destroyPad();

		currentState = state;

		currentPad = ButtonHelper.create(
			state,
			config.layout,
			config.buttonType()
		);

		ButtonHelper.bind(
			currentPad,
			['ui_up', 'ui_down', 'ui_left', 'ui_right'],
			config.buttons
		);

		state.add(currentPad);
		#end
	}

	#if mobile
	public static function hide():Void
	{
		if (currentPad != null)
			currentPad.visible = false;
	}

	public static function show():Void
	{
		if (currentPad != null)
			currentPad.visible = true;
	}
	#end

	#if mobile
	public static function destroyPad():Void
	{
		if (currentPad == null) return;

		currentPad.kill();
		currentPad.destroy();
		currentPad = null;
	}
	#end

	public static function isAvailable():Bool
	{
		#if mobile
		return true;
		#else
		return false;
		#end
	}
}
