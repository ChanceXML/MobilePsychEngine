package;

import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
#if android
import extension.saf.SAF;
#end

class AndroidModSync
{
    public static var isSyncing:Bool = false;

    public static function pickModsFolder():Void
    {
        #if android
        SAF.open(function(uri:String) {
            if (ClientPrefs.data != null) {
                ClientPrefs.data.modsFolder = uri;
            }
        }, function(err:String) {
            trace(err);
        });
        #end
    }

    public static function syncModsFromSAF():Void
    {
        var sourceFolder = "";
        if (ClientPrefs.data != null && ClientPrefs.data.modsFolder != null) {
            sourceFolder = ClientPrefs.data.modsFolder;
        }

        if (sourceFolder == "" || isSyncing) return;
        
        isSyncing = true;
        
        var cwd = Sys.getCwd();
        if (cwd == null) cwd = "";
        var destFolder = Path.join([cwd, "assets", "mods"]);

        try {
            if (!FileSystem.exists(destFolder)) {
                FileSystem.createDirectory(destFolder);
            }
        } catch(e:Dynamic) {
            trace(e);
        }

        #if android
        try {
            copyFolder(sourceFolder, destFolder);
        } catch (e:Dynamic) {
            trace(e);
        }
        isSyncing = false;
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
            
            var isDir = false;
            if (split.length >= 3) {
                isDir = (split[2] == "true");
            } else {
                isDir = (fileName.indexOf(".") == -1);
            }

            if (isDir)
            {
                try {
                    if (!FileSystem.exists(dstPath)) {
                        FileSystem.createDirectory(dstPath);
                    }
                    copyFolder(fileUri, dstPath);
                } catch(e:Dynamic) {
                    trace(e);
                }
            }
            else
            {
                try {
                    if (FileSystem.exists(dstPath)) {
                        FileSystem.deleteFile(dstPath);
                    }

                    var ok = SAF.copyToInternal(fileUri, dstPath);
                    if (!ok) {
                        trace(fileUri);
                    }
                } catch (e:Dynamic) {
                    trace(e);
                }
            }
        }
        #end
    }
}
