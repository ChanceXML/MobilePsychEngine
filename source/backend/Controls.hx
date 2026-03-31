package backend;

import flixel.FlxG;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

#if mobile
import android.controls.VirtualPad;
#end

class Controls
{
	public var UI_UP_P(get, never):Bool;
	public var UI_DOWN_P(get, never):Bool;
	public var UI_LEFT_P(get, never):Bool;
	public var UI_RIGHT_P(get, never):Bool;

	public var NOTE_UP_P(get, never):Bool;
	public var NOTE_DOWN_P(get, never):Bool;
	public var NOTE_LEFT_P(get, never):Bool;
	public var NOTE_RIGHT_P(get, never):Bool;

	inline function get_UI_UP_P() return justPressed('ui_up');
	inline function get_UI_DOWN_P() return justPressed('ui_down');
	inline function get_UI_LEFT_P() return justPressed('ui_left');
	inline function get_UI_RIGHT_P() return justPressed('ui_right');
	inline function get_NOTE_UP_P() return justPressed('note_up');
	inline function get_NOTE_DOWN_P() return justPressed('note_down');
	inline function get_NOTE_LEFT_P() return justPressed('note_left');
	inline function get_NOTE_RIGHT_P() return justPressed('note_right');

	public var UI_UP(get, never):Bool;
	public var UI_DOWN(get, never):Bool;
	public var UI_LEFT(get, never):Bool;
	public var UI_RIGHT(get, never):Bool;

	public var NOTE_UP(get, never):Bool;
	public var NOTE_DOWN(get, never):Bool;
	public var NOTE_LEFT(get, never):Bool;
	public var NOTE_RIGHT(get, never):Bool;

	inline function get_UI_UP() return pressed('ui_up');
	inline function get_UI_DOWN() return pressed('ui_down');
	inline function get_UI_LEFT() return pressed('ui_left');
	inline function get_UI_RIGHT() return pressed('ui_right');
	inline function get_NOTE_UP() return pressed('note_up');
	inline function get_NOTE_DOWN() return pressed('note_down');
	inline function get_NOTE_LEFT() return pressed('note_left');
	inline function get_NOTE_RIGHT() return pressed('note_right');

	public var UI_UP_R(get, never):Bool;
	public var UI_DOWN_R(get, never):Bool;
	public var UI_LEFT_R(get, never):Bool;
	public var UI_RIGHT_R(get, never):Bool;

	public var NOTE_UP_R(get, never):Bool;
	public var NOTE_DOWN_R(get, never):Bool;
	public var NOTE_LEFT_R(get, never):Bool;
	public var NOTE_RIGHT_R(get, never):Bool;

	inline function get_UI_UP_R() return justReleased('ui_up');
	inline function get_UI_DOWN_R() return justReleased('ui_down');
	inline function get_UI_LEFT_R() return justReleased('ui_left');
	inline function get_UI_RIGHT_R() return justReleased('ui_right');
	inline function get_NOTE_UP_R() return justReleased('note_up');
	inline function get_NOTE_DOWN_R() return justReleased('note_down');
	inline function get_NOTE_LEFT_R() return justReleased('note_left');
	inline function get_NOTE_RIGHT_R() return justReleased('note_right');

	public var ACCEPT(get, never):Bool;
	public var BACK(get, never):Bool;
	public var PAUSE(get, never):Bool;
	public var RESET(get, never):Bool;

	inline function get_ACCEPT() return justPressed('accept');
	inline function get_BACK() return justPressed('back');
	inline function get_PAUSE() return justPressed('pause');
	inline function get_RESET() return justPressed('reset');

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

	inline function getKeyboard(key:String):Array<FlxKey>
	{
		return keyboardBinds != null ? keyboardBinds.get(key) : null;
	}

	inline function getGamepad(key:String):Array<FlxGamepadInputID>
	{
		return gamepadBinds != null ? gamepadBinds.get(key) : null;
	}

	public function justPressed(key:String):Bool
	{
		var result = false;

		#if mobile
		if (virtualPad != null && virtualPad.justPressed(key))
			result = true;
		#end

		var keys = getKeyboard(key);
		if (keys != null && FlxG.keys.anyJustPressed(keys))
		{
			controllerMode = false;
			result = true;
		}

		var pads = getGamepad(key);
		if (pads != null)
		{
			for (p in pads)
			{
				if (FlxG.gamepads.anyJustPressed(p))
				{
					controllerMode = true;
					result = true;
					break;
				}
			}
		}

		return result;
	}

	public function pressed(key:String):Bool
	{
		var result = false;

		#if mobile
		if (virtualPad != null && virtualPad.pressed(key))
			result = true;
		#end

		var keys = getKeyboard(key);
		if (keys != null && FlxG.keys.anyPressed(keys))
		{
			controllerMode = false;
			result = true;
		}

		var pads = getGamepad(key);
		if (pads != null)
		{
			for (p in pads)
			{
				if (FlxG.gamepads.anyPressed(p))
				{
					controllerMode = true;
					result = true;
					break;
				}
			}
		}

		return result;
	}

	public function justReleased(key:String):Bool
	{
		var result = false;

		#if mobile
		if (virtualPad != null && virtualPad.justReleased(key))
			result = true;
		#end

		var keys = getKeyboard(key);
		if (keys != null && FlxG.keys.anyJustReleased(keys))
		{
			controllerMode = false;
			result = true;
		}

		var pads = getGamepad(key);
		if (pads != null)
		{
			for (p in pads)
			{
				if (FlxG.gamepads.anyJustReleased(p))
				{
					controllerMode = true;
					result = true;
					break;
				}
			}
		}

		return result;
	}
}
