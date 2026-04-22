import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
#if android
import extension.saf.SAF;
#end

class AndroidModSync
{
    public static function pickModsFolder():Void
    {
        #if android
        SAF.open(function(uri:String) {
            ClientPrefs.data.modsFolder = uri;
        }, function(err:String) {
        });
        #end
    }

    public static function syncModsFromSAF():Void
    {
        var sourceFolder = ClientPrefs.data.modsFolder;

        if (sourceFolder == null || sourceFolder == "")
        {
            return;
        }
        
        var destFolder = Path.join([Sys.getCwd(), "assets", "mods"]);

        if (!FileSystem.exists(destFolder))
        {
            FileSystem.createDirectory(destFolder);
        }

        #if android
        copyFolder(sourceFolder, destFolder);
        #end
    }

    private static function copyFolder(srcUri:String, dst:String):Void
    {
        #if android
        var files = SAF.listFiles(srcUri);

        for (fileData in files)
        {
            var split = fileData.split("|");
            var fileName = split[0];
            var fileUri = split[1];
            var dstPath = Path.join([dst, fileName]);

            var isDir = fileName.indexOf(".") == -1;

            if (isDir)
            {
                if (!FileSystem.exists(dstPath))
                    FileSystem.createDirectory(dstPath);

                copyFolder(fileUri, dstPath);
            }
            else
            {
                try
                {
                    File.copy(fileUri, dstPath);
                }
                catch (e:Dynamic)
                {
                }
            }
        }
        #end
    }
}
