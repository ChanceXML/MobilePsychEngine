package android.utils;

#if android
import extension.androidtools.os.Build.VERSION;
import extension.androidtools.Permissions;
import lime.system.JNI;
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
	// =========================
	// 📁 DIRECTORY
	// =========================
	public static function getDirectory():String
	{
		#if android
		return "/storage/emulated/0/Android/data/com.shadowmario.psychengine/files/";
		#else
		return "";
		#end
	}

	// =========================
	// 🔐 PERMISSIONS
	// =========================
	public static function requestPermissions():Void
	{
		#if android
		try {
			if (VERSION.SDK_INT < 30) {
				Permissions.requestPermissions([
					"READ_EXTERNAL_STORAGE",
					"WRITE_EXTERNAL_STORAGE"
				]);
			}
		} catch (e:Dynamic) {
			trace("Permission error: " + e);
		}
		#end
	}

	// =========================
	// 📱 LOADING DIALOG
	// =========================
	#if android
	private static var showDialog:Dynamic = null;
	private static var hideDialog:Dynamic = null;
	#end

	private static function initDialog():Void
	{
		#if android
		try {
			if (showDialog == null) {
				showDialog = JNI.createStaticMethod(
					"org/haxe/extension/Extension",
					"showLoading",
					"(Ljava/lang/String;)V"
				);
				hideDialog = JNI.createStaticMethod(
					"org/haxe/extension/Extension",
					"hideLoading",
					"()V"
				);
			}
		} catch (e:Dynamic) {
			trace("JNI dialog not available (safe to ignore)");
		}
		#end
	}

	private static function showLoading(msg:String):Void
	{
		#if android
		initDialog();
		try {
			if (showDialog != null) showDialog(msg);
		} catch (e:Dynamic) {}
		#end
	}

	private static function hideLoading():Void
	{
		#if android
		try {
			if (hideDialog != null) hideDialog();
		} catch (e:Dynamic) {}
		#end
	}

	// =========================
	// 🚀 INIT 
	// =========================
	public static function init():Void
	{
		#if android
		requestPermissions();

		var base = getDirectory();
		ensureDir(base);

		showLoading("Preparing files...");

		try {
			if (!FileSystem.exists(base + "assets/")) {
				trace("Copying assets...");
				copyAssets("assets/", base + "assets/");
			}

			if (!FileSystem.exists(base + "mods/")) {
				trace("Copying mods...");
				copyAssets("mods/", base + "mods/");
			}
		}
		catch (e:Dynamic) {
			trace("Copy error: " + e);
		}

		hideLoading();
		#end
	}

	// =========================
	// 📦 COPY FROM APK
	// =========================
	private static function copyAssets(source:String, target:String):Void
	{
		#if android
		try {
			ensureDir(target);

			var clean = source;
			if (clean.endsWith("/"))
				clean = clean.substr(0, clean.length - 1);

			var list = Assets.list();

			for (asset in list)
			{
				if (!asset.startsWith(clean)) continue;

				var relative = asset;

				if (relative.startsWith("assets/"))
					relative = relative.substr(7);

				if (relative == "") continue;

				var outPath = target + relative;

				var dir = haxe.io.Path.directory(outPath);
				if (dir != "" && !FileSystem.exists(dir))
					createDirRecursive(dir);

				try {
					if (Assets.exists(asset))
					{
						var bytes:Bytes = Assets.getBytes(asset);

						if (bytes != null) {
							File.saveBytes(outPath, bytes);
						} else {
							var text = Assets.getText(asset);
							if (text != null)
								File.saveContent(outPath, text);
						}
					}
				}
				catch (e:Dynamic) {
					trace("Copy error: " + asset + " -> " + e);
				}
			}

			trace("Finished: " + target);
		}
		catch (e:Dynamic) {
			trace("FATAL copy error: " + e);
		}
		#end
	}

	// =========================
	// 📁 HELPERS
	// =========================
	private static function ensureDir(path:String):Void
	{
		#if sys
		if (!FileSystem.exists(path)) {
			FileSystem.createDirectory(path);
		}
		#end
	}

	private static function createDirRecursive(path:String):Void
	{
		#if sys
		var parts = path.split("/");
		var cur = "";

		for (p in parts)
		{
			if (p == "") continue;

			cur += "/" + p;

			if (!FileSystem.exists(cur)) {
				try {
					FileSystem.createDirectory(cur);
				} catch (e:Dynamic) {}
			}
		}
		#end
	}
}
