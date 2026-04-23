package;

import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
#if android
import extension.saf.SAF;
import sys.thread.Thread;
#end

class AndroidModSync
{
    public static var isSyncing:Bool = false;

    public static function pickModsFolder():Void
    {
        #if android
        SAF.open(function(uri:String) {
            if (ClientPrefs.data != null) ClientPrefs.data.modsFolder = uri;
        }, function(err:String) {
            trace("SAF Error: " + err);
        });
        #end
    }

    public static function syncModsFromSAF():Void
    {
        var sourceFolder = (ClientPrefs.data != null) ? ClientPrefs.data.modsFolder : "";

        if (sourceFolder == null || sourceFolder == "" || isSyncing) return;
        
        isSyncing = true;
        var destFolder = Path.join([Sys.getCwd(), "assets", "mods"]);

        try {
            if (!FileSystem.exists(destFolder)) FileSystem.createDirectory(destFolder);
        } catch(e:Dynamic) {}

        #if android
        Thread.create(function() {
            try {
                copyFolder(sourceFolder, destFolder);
            } catch (e:Dynamic) {
                trace("Sync Thread Error: " + e);
            }
            isSyncing = false;
        });
        #end
    }

    private static function copyFolder(srcUri:String, dst:String):Void
{
    #if android
    var files = SAF.listFiles(srcUri);
    if (files == null || files.length == 0) return;

    for (fileData in files)
    {
        var split = fileData.split("|");
        if (split.length < 2) continue;

        var fileName = split[0];
        var fileUri = split[1];
        var dstPath = Path.join([dst, fileName]);
        
        var isDir = (split.length >= 3) ? (split[2] == "true") : (fileName.indexOf(".") == -1);

        if (isDir)
        {
            try {
                if (!FileSystem.exists(dstPath)) FileSystem.createDirectory(dstPath);
                copyFolder(fileUri, dstPath);
            } catch(e:Dynamic) {}
        }
        else
        {
            try {
                if (FileSystem.exists(dstPath)) FileSystem.deleteFile(dstPath);

                var ok = SAF.copyToInternal(fileUri, dstPath);
                if (!ok) {
                    trace("Failed copying: " + fileUri);
                }

            } catch (e:Dynamic) {
                trace("Copy error: " + e);
            }
        }
    }
    #end
    }
}
