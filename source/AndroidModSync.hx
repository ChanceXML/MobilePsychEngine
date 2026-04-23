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
            
            haxe.MainLoop.runInMainThread(function() {
                ClientPrefs.data.modsFolder = uri;
                trace("SAF Mods folder selected: " + uri);
                
            });
            
        }, function(err:String) {
            trace("SAF Error: " + err);
        });
        #end
    }

    public static function syncModsFromSAF():Void
    {
        var sourceFolder = ClientPrefs.data.modsFolder;

        if (sourceFolder == null || sourceFolder == "") {
            trace("No mods folder has been selected yet.");
            return;
        }

        if (isSyncing) {
            trace("Already syncing mods! Please wait...");
            return;
        }
        
        isSyncing = true;
        
        var destFolder = Path.join([Sys.getCwd(), "assets", "mods"]);

        if (!FileSystem.exists(destFolder)) {
            FileSystem.createDirectory(destFolder);
        }

        #if android
        Thread.create(function() {
            try {
                trace("Starting background mod sync...");
                copyFolder(sourceFolder, destFolder);
                trace("Mod sync successfully completed!");
            } catch (e:Dynamic) {
                trace("CRITICAL ERROR during mod sync: " + e);
            }
            
            isSyncing = false;
        });
        #end
    }

    private static function copyFolder(srcUri:String, dst:String):Void
    {
        #if android
        var files:Array<String> = null;
        
        try {
            files = SAF.listFiles(srcUri);
        } catch(e:Dynamic) {
            trace("Failed to list SAF directory: " + e);
            return;
        }

        if (files == null || files.length == 0) return;

        for (fileData in files)
        {
            var split = fileData.split("|");
            
            if (split.length < 2) continue; 
            
            var fileName = split[0];
            var fileUri = split[1];
            var dstPath = Path.join([dst, fileName]);

            var isDir:Bool = false;
            
            if (split.length >= 3) {
                isDir = (split[2] == "true" || split[2] == "1");
            } else {
                var noExtension = fileName.indexOf(".") == -1;
                var commonFolders = ["data", "songs", "images", "characters", "stages", "custom_events", "scripts", "fonts", "weeks"];
                isDir = noExtension || commonFolders.indexOf(fileName.toLowerCase()) != -1;
            }

            if (isDir)
            {
                if (!FileSystem.exists(dstPath)) {
                    FileSystem.createDirectory(dstPath);
                }
                
                copyFolder(fileUri, dstPath);
            }
            else
            {
                try
                {
                    if (FileSystem.exists(dstPath)) {
                        FileSystem.deleteFile(dstPath);
                    }
                    
                    File.copy(fileUri, dstPath);
                }
                catch (e:Dynamic)
                {
                    trace("Failed to copy file " + fileName + ". Error: " + e);
                }
            }
        }
        #end
    }
}
