package;

import sys.FileSystem;
import sys.io.File;

class AndroidModSync
{
    public static function syncModsFromSAF()
    {
        var sourceFolder = ClientPrefs.data.modsFolder;

        if (sourceFolder == null || sourceFolder == "")
        {
            trace("No SAF mods folder set.");
            return;
        }

        trace("Syncing mods from SAF: " + sourceFolder);

        var destFolder = Sys.getCwd() + "assets/mods/";

        if (!FileSystem.exists(destFolder))
        {
            FileSystem.createDirectory(destFolder);
        }

        copyFolder(sourceFolder, destFolder);

        trace("Mods sync complete!");
    }

    private static function copyFolder(src:String, dst:String)
    {
        if (!FileSystem.exists(src)) return;

        for (file in FileSystem.readDirectory(src))
        {
            var srcPath = src + "/" + file;
            var dstPath = dst + "/" + file;

            if (FileSystem.isDirectory(srcPath))
            {
                if (!FileSystem.exists(dstPath))
                    FileSystem.createDirectory(dstPath);

                copyFolder(srcPath, dstPath);
            }
            else
            {
                try
                {
                    File.copy(srcPath, dstPath);
                }
                catch (e)
                {
                    trace("Failed copying: " + srcPath);
                }
            }
        }
    }
}
