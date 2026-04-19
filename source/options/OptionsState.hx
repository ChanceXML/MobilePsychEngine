package options;

import states.MainMenuState;
import backend.StageData;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.math.FlxMath;

#if mobile
import backend.ClientPrefs;
import android.controls.VirtualPad;
import android.utils.ButtonHelper;
#end

class OptionsState extends MusicBeatState
{
	var options:Array<String> = [
		'Android',
		'Note Colors',
		'Controls',
		'Adjust Delay and Combo',
		'Graphics',
		'Visuals',
		'Gameplay'
		#if TRANSLATIONS_ALLOWED , 'Language' #end
	];

	#if mobile
	public static var globalPad:VirtualPad;
	public var virtualPad:VirtualPad;
	#end

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	public static var onPlayState:Bool = false;

	override function create()
	{
		super.create();

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Options Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xFFea71fd;
		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (num => option in options)
		{
			var optionText = new Alphabet(0, 0, Language.getPhrase('options_$option', option), true);
			optionText.screenCenter();
			optionText.y += (92 * (num - (options.length / 2))) + 45;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);

		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		#if mobile
		if (globalPad == null)
		{
			virtualPad = ButtonHelper.create(this, FULL, A_B);

			ButtonHelper.bind(
				virtualPad,
				['ui_up', 'ui_down', 'ui_left', 'ui_right'],
				['accept', 'back']
			);

			add(virtualPad);
			globalPad = virtualPad;
		}
		else
		{
			virtualPad = globalPad;
			add(virtualPad);
		}
		#end
	}

	#if mobile
	override function openSubState(state:FlxSubState)
	{
		super.openSubState(state);
	}

	override function closeSubState()
	{
		super.closeSubState();

		if (virtualPad != null)
			virtualPad.visible = true;

		ClientPrefs.saveSettings();
	}
	#end

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UI_UP_P)
			changeSelection(-1);
		if (controls.UI_DOWN_P)
			changeSelection(1);

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));

			if (onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
			}
			else
				MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT)
			openSelectedSubstate(options[curSelected]);
	}

	function openSelectedSubstate(label:String)
	{
		switch(label)
		{
			case 'Android':
				openSubState(new options.AndroidSubState());
			case 'Note Colors':
				openSubState(new options.NotesColorSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals':
				openSubState(new options.VisualsSettingsSubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
			case 'Language':
				openSubState(new options.LanguageSubState());
		}
	}

	function changeSelection(change:Int = 0)
	{
		curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);

		for (num => item in grpOptions.members)
		{
			item.targetY = num - curSelected;
			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		#if mobile
		if (globalPad == virtualPad)
			globalPad = null;

		if (virtualPad != null)
		{
			remove(virtualPad);
			virtualPad.kill();
			virtualPad.destroy();
			virtualPad = null;
		}
		#end

		super.destroy();
	}
}
