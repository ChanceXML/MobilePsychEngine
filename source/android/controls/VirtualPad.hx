package android.controls;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;

class VirtualPad extends FlxSpriteGroup
{
	public var camera:FlxCamera;

	private static var atlas:FlxAtlasFrames;

	public var binds:Map<String, Array<FlxButton>> = new Map();

	public function new()
	{
		super();

		camera = new FlxCamera();
		camera.bgColor = 0x00000000;
		FlxG.cameras.add(camera, false);
		this.cameras = [camera];

		if (atlas == null)
		{
			atlas = FlxAtlasFrames.fromSpriteSheetPacker(
				'assets/shared/images/mobile/controls/classic/virtual-input-classic.png',
				'assets/shared/images/mobile/controls/classic/virtual-input-classic.txt'
			);
		}
	}

	public function addButton(x:Float, y:Float, key:String, frame:String, w:Int, h:Int)
	{
		var btn = new FlxButton(x, y);

		btn.frames = atlas;
		btn.animation.frameName = frame;

		btn.setGraphicSize(w, h);
		btn.updateHitbox();
		btn.scrollFactor.set();

		add(btn);

		if (!binds.exists(key)) binds.set(key, []);
		binds.get(key).push(btn);
	}

	public function justPressed(key:String):Bool
	{
		if (!binds.exists(key)) return false;

		for (b in binds.get(key))
			if (b.justPressed) return true;

		return false;
	}

	public function pressed(key:String):Bool
	{
		if (!binds.exists(key)) return false;

		for (b in binds.get(key))
			if (b.pressed) return true;

		return false;
	}

	public function justReleased(key:String):Bool
	{
		if (!binds.exists(key)) return false;

		for (b in binds.get(key))
			if (b.justReleased) return true;

		return false;
	}

	override public function destroy()
	{
		super.destroy();

		if (camera != null)
		{
			FlxG.cameras.remove(camera);
			camera.destroy();
			camera = null;
		}
	}
}
