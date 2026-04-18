package android.utils;

#if android
import extension.androidtools.content.Context;
#end

import openfl.Assets;
import haxe.io.Bytes;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class Files
{
	public static function getBase():String
	{
		#if android
		return Context.getExternalFilesDir() + "/";
		#else
		return "";
		#end
	}

	public static function init():Void
	{
		#if android
		var base = getBase();

		copyFolderOnce("assets", base + "assets/");
		copyFolderOnce("mods", base + "mods/");
		#end
	}

	// copy if folder doesnt exist
	static function copyFolderOnce(folder:String, target:String):Void
	{
		if (FileSystem.exists(target))
		{
			trace(folder + " already exists, skipping.");
			return;
		}

		trace("Copying " + folder + "...");
		copyAssets(folder, target);
	}

	// copy files from the apk
	static function copyAssets(source:String, target:String):Void
	{
		var list = Assets.list();

		for (asset in list)
		{
			if (!asset.startsWith(source)) continue;

			var relative = asset.substr(source.length);
			if (relative.startsWith("/")) relative = relative.substr(1);

			var outPath = target + relative;

			createDirRecursive(haxe.io.Path.directory(outPath));

			try {
				var bytes:Bytes = Assets.getBytes(asset);

				if (bytes != null)
					File.saveBytes(outPath, bytes);
				else
					File.saveContent(outPath, Assets.getText(asset));

			} catch (e:Dynamic) {
				trace("Failed: " + asset + " -> " + e);
			}
		}

		trace("Finished copying " + source);
	}

	// dir creation
	static function createDirRecursive(path:String):Void
	{
		if (path == null || path == "") return;

		if (!FileSystem.exists(path))
			FileSystem.createDirectory(path);
	}
}
