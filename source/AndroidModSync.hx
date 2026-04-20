import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;

class AndroidModSync
{
    static var fileCache:Map<String, Float> = new Map();


    public static function pickModsFolder():Void
    {
        if (flixel.FlxG.sound != null)
            flixel.FlxG.sound.play(Paths.sound('confirmMenu'));

        #if android
        try 
        {
            var openPicker = JNI.createStaticMethod("com/shadowmario/psychengine/SAFBridge", "openModsFolderPicker", "()V");
            
            openPicker();
        } 
        catch (e:Dynamic) 
        {
            trace("JNI Error: Failed to open SAF picker - " + e);
        }
        #else
        trace("SAF Folder Picker is only available on Android!");
        #end
    }
    
    public static function syncModsFromSAF():Void
    {
        var sourceFolder = ClientPrefs.data.modsFolder;

        if (sourceFolder == null || sourceFolder == "")
        {
            trace("No SAF mods folder set.");
            return;
        }

        trace("Syncing mods from SAF: " + sourceFolder);
        
        var destFolder = Path.join([Sys.getCwd(), "assets", "mods"]);

        if (!FileSystem.exists(destFolder))
        {
            FileSystem.createDirectory(destFolder);
        }

        copyFolder(sourceFolder, destFolder);

        trace("Mods sync complete!");
    }

    private static function copyFolder(src:String, dst:String):Void
    {
        if (!FileSystem.exists(src)) return;

        for (file in FileSystem.readDirectory(src))
        {
            var srcPath = Path.join([src, file]);
            var dstPath = Path.join([dst, file]);

            if (FileSystem.isDirectory(srcPath))
            {
                if (!FileSystem.exists(dstPath))
                    FileSystem.createDirectory(dstPath);

                copyFolder(srcPath, dstPath);
            }
            else
            {
                var shouldCopy:Bool = false;

                try
                {
                    var srcTime = FileSystem.stat(srcPath).mtime.getTime();

                    if (!fileCache.exists(srcPath) || fileCache.get(srcPath) != srcTime)
                    {
                        shouldCopy = true;
                        fileCache.set(srcPath, srcTime);
                    }
                }
                catch (e:Dynamic)
                {
                    shouldCopy = true;
                }

                if (shouldCopy)
                {
                    try
                    {
                        File.copy(srcPath, dstPath);
                        trace("Updated file: " + srcPath);
                    }
                    catch (e:Dynamic)
                    {
                        trace("Failed copying: " + srcPath + " | Error: " + e);
                    }
                }
            }
        }
    }
}
