package backend;

import flixel.FlxG;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

#if mobile
import android.controls.VirtualPad;
#end

class Controls
{
	// mobile friendly. i think..

	// Directions - just pressed
	public var UI_UP_P(get, never):Bool;
	public var UI_DOWN_P(get, never):Bool;
	public var UI_LEFT_P(get, never):Bool;
	public var UI_RIGHT_P(get, never):Bool;

	public var NOTE_UP_P(get, never):Bool;
	public var NOTE_DOWN_P(get, never):Bool;
	public var NOTE_LEFT_P(get, never):Bool;
	public var NOTE_RIGHT_P(get, never):Bool;

	private function get_UI_UP_P() return justPressed('ui_up');
	private function get_UI_DOWN_P() return justPressed('ui_down');
	private function get_UI_LEFT_P() return justPressed('ui_left');
	private function get_UI_RIGHT_P() return justPressed('ui_right');
	private function get_NOTE_UP_P() return justPressed('note_up');
	private function get_NOTE_DOWN_P() return justPressed('note_down');
	private function get_NOTE_LEFT_P() return justPressed('note_left');
	private function get_NOTE_RIGHT_P() return justPressed('note_right');

	// Directions - held
	public var UI_UP(get, never):Bool;
	public var UI_DOWN(get, never):Bool;
	public var UI_LEFT(get, never):Bool;
	public var UI_RIGHT(get, never):Bool;

	public var NOTE_UP(get, never):Bool;
	public var NOTE_DOWN(get, never):Bool;
	public var NOTE_LEFT(get, never):Bool;
	public var NOTE_RIGHT(get, never):Bool;

	private function get_UI_UP() return pressed('ui_up');
	private function get_UI_DOWN() return pressed('ui_down');
	private function get_UI_LEFT() return pressed('ui_left');
	private function get_UI_RIGHT() return pressed('ui_right');
	private function get_NOTE_UP() return pressed('note_up');
	private function get_NOTE_DOWN() return pressed('note_down');
	private function get_NOTE_LEFT() return pressed('note_left');
	private function get_NOTE_RIGHT() return pressed('note_right');

	// Directions - released
	public var UI_UP_R(get, never):Bool;
	public var UI_DOWN_R(get, never):Bool;
	public var UI_LEFT_R(get, never):Bool;
	public var UI_RIGHT_R(get, never):Bool;

	public var NOTE_UP_R(get, never):Bool;
	public var NOTE_DOWN_R(get, never):Bool;
	public var NOTE_LEFT_R(get, never):Bool;
	public var NOTE_RIGHT_R(get, never):Bool;

	private function get_UI_UP_R() return justReleased('ui_up');
	private function get_UI_DOWN_R() return justReleased('ui_down');
	private function get_UI_LEFT_R() return justReleased('ui_left');
	private function get_UI_RIGHT_R() return justReleased('ui_right');
	private function get_NOTE_UP_R() return justReleased('note_up');
	private function get_NOTE_DOWN_R() return justReleased('note_down');
	private function get_NOTE_LEFT_R() return justReleased('note_left');
	private function get_NOTE_RIGHT_R() return justReleased('note_right');

	// Other actions
	public var ACCEPT(get, never):Bool;
	public var BACK(get, never):Bool;
	public var PAUSE(get, never):Bool;
	public var RESET(get, never):Bool;

	private function get_ACCEPT() return justPressed('accept');
	private function get_BACK() return justPressed('back');
	private function get_PAUSE() return justPressed('pause');
	private function get_RESET() return justPressed('reset');

	// Binds
	public var keyboardBinds:Map<String, Array<FlxKey>>;
	public var gamepadBinds:Map<String, Array<FlxGamepadInputID>>;

	#if mobile
	public static var virtualPad:VirtualPad;
	#end

	public var controllerMode:Bool = false;

	public static var instance:Controls;

	public function new()
	{
		instance = this;
		keyboardBinds = ClientPrefs.keyBinds;
		gamepadBinds = ClientPrefs.gamepadBinds;
	}

	public function justPressed(key:String):Bool
	{
		#if mobile
		if (virtualPad != null && virtualPad.justPressed(key))
		{
			controllerMode = false;
			return true;
		}
		#end

		var keyboardResult:Bool = _keyboardJustPressed(key);
		if (keyboardResult) controllerMode = false;

		var gamepadResult:Bool = _gamepadJustPressed(key);
		return keyboardResult || gamepadResult;
	}

	public function pressed(key:String):Bool
	{
		#if mobile
		if (virtualPad != null && virtualPad.pressed(key))
		{
			controllerMode = false;
			return true;
		}
		#end

		var keyboardResult:Bool = _keyboardPressed(key);
		if (keyboardResult) controllerMode = false;

		var gamepadResult:Bool = _gamepadPressed(key);
		return keyboardResult || gamepadResult;
	}

	public function justReleased(key:String):Bool
	{
		#if mobile
		if (virtualPad != null && virtualPad.justReleased(key))
		{
			controllerMode = false;
			return true;
		}
		#end

		var keyboardResult:Bool = _keyboardJustReleased(key);
		if (keyboardResult) controllerMode = false;

		var gamepadResult:Bool = _gamepadJustReleased(key);
		return keyboardResult || gamepadResult;
	}

	private inline function _keyboardJustPressed(key:String):Bool
	{
		var binds = keyboardBinds != null ? keyboardBinds.get(key) : null;
		return binds != null && FlxG.keys.anyJustPressed(binds);
	}

	private inline function _keyboardPressed(key:String):Bool
	{
		var binds = keyboardBinds != null ? keyboardBinds.get(key) : null;
		return binds != null && FlxG.keys.anyPressed(binds);
	}

	private inline function _keyboardJustReleased(key:String):Bool
	{
		var binds = keyboardBinds != null ? keyboardBinds.get(key) : null;
		return binds != null && FlxG.keys.anyJustReleased(binds);
	}

	private function _gamepadJustPressed(key:String):Bool
	{
		var binds = gamepadBinds != null ? gamepadBinds.get(key) : null;
		if (binds != null)
		{
			for (bind in binds)
			{
				if (FlxG.gamepads.anyJustPressed(bind))
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}

	private function _gamepadPressed(key:String):Bool
	{
		var binds = gamepadBinds != null ? gamepadBinds.get(key) : null;
		if (binds != null)
		{
			for (bind in binds)
			{
				if (FlxG.gamepads.anyPressed(bind))
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}

	private function _gamepadJustReleased(key:String):Bool
	{
		var binds = gamepadBinds != null ? gamepadBinds.get(key) : null;
		if (binds != null)
		{
			for (bind in binds)
			{
				if (FlxG.gamepads.anyJustReleased(bind))
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
}
