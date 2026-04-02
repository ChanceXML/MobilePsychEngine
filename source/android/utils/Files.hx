package android.utils;

import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
import sys.thread.Thread;
import haxe.io.Bytes;

#if android
import lime.system.JNI;
#end

/**
 * Advanced Asynchronous File Manager with Native Android Hooks
 * Handles deep directory traversal, chunk-based file copying, and JNI Toast popups.
 */
class Files {
    public static var isTransferring:Bool = false;
    public static var totalFiles:Int = 0;
    public static var filesCopied:Int = 0;
    public static var totalBytes:Float = 0;
    public static var bytesCopied:Float = 0;

    private static inline var BUFFER_SIZE:Int = 1048576; 

    #if android
    private static var showToastJNI:Dynamic = null;
    #end
      
    public static function startTransfer():Void {
        if (isTransferring) {
            trace("Transfer already in progress. Aborting new request.");
            return;
        }

        isTransferring = true;
        totalFiles = 0;
        filesCopied = 0;
        totalBytes = 0;
        bytesCopied = 0;

        initNativeHooks();

        showNativePopup("Transferring Files... Please wait.");

        Thread.create(function() {
            var destRoot = "/storage/emulated/0/Android/data/com.shadowmario.psychengine/files/";

            try {
                ensureDirectory(destRoot);

                var sourceAssets = "assets";
                var destAssets = destRoot + "assets";
                var sourceMods = "mods";
                var destMods = destRoot + "mods";

                trace("Scanning directories...");
                scanDirectory(sourceAssets);
                scanDirectory(sourceMods);
                
                trace('Scan complete. Total files to transfer: $totalFiles');

                showNativePopup('Copying $totalFiles files...');
                
                copyDirectory(sourceAssets, destAssets);
                copyDirectory(sourceMods, destMods);

                showNativePopup("File Transfer Complete!");
                trace("All files transferred successfully.");

            } catch (e:Dynamic) {
                trace("CRITICAL ERROR DURING TRANSFER: " + e);
                showNativePopup("Error transferring files!");
            }

            isTransferring = false;
        });
    }

    /**
     * Initializes the Java Native Interface bindings for Android.
     */
    private static function initNativeHooks():Void {
        #if android
        try {
            if (showToastJNI == null) {
                showToastJNI = JNI.createStaticMethod("org/haxe/extension/Extension", "showToast", "(Ljava/lang/String;I)V");
            }
        } catch (e:Dynamic) {
            trace("Failed to initialize JNI hooks: " + e);
        }
        #end
    }

    /**
     * Triggers the native Android internal popup (Toast).
     * @param message The text to display
     */
    private static function showNativePopup(message:String):Void {
        trace("POPUP: " + message);
        #if android
        try {
            if (showToastJNI != null) {
                showToastJNI(message, 1); 
            }
        } catch (e:Dynamic) {
            trace("Error displaying native popup: " + e);
        }
        #end
    }

    /**
     * Recursively scans a directory to count total files and calculate total bytes.
     * This ensures the script knows exactly how much work it has to do.
     */
    private static function scanDirectory(source:String):Void {
        if (!FileSystem.exists(source)) return;

        var entries:Array<String> = FileSystem.readDirectory(source);
        for (entry in entries) {
            var path = source + "/" + entry;
            if (FileSystem.isDirectory(path)) {
                scanDirectory(path);
            } else {
                totalFiles++;
                var stat = FileSystem.stat(path);
                totalBytes += stat.size;
            }
        }
    }

    /**
     * Recursively creates directory structures if they do not exist.
     */
    private static function ensureDirectory(path:String):Void {
        if (!FileSystem.exists(path)) {
            trace("Creating directory: " + path);
            FileSystem.createDirectory(path);
        }
    }

    /**
     * Handles the recursive traversal and delegation of file copying.
     */
    private static function copyDirectory(source:String, destination:String):Void {
        if (!FileSystem.exists(source)) return;
        ensureDirectory(destination);

        var entries:Array<String> = FileSystem.readDirectory(source);
        for (entry in entries) {
            var srcPath = source + "/" + entry;
            var dstPath = destination + "/" + entry;

            if (FileSystem.isDirectory(srcPath)) {
                copyDirectory(srcPath, dstPath); 
            } else {
                copyFileChunked(srcPath, dstPath);
                filesCopied++;
                
                if (filesCopied % 50 == 0) {
                    var percentage = Math.floor((filesCopied / totalFiles) * 100);
                    showNativePopup('Transferring... $percentage% ($filesCopied / $totalFiles)');
                }
            }
        }
    }

    /**
     * Advanced file copying method that reads and writes in chunks.
     * This prevents OutOfMemory exceptions on low-end Android devices when copying huge mod files (like video cutscenes).
     */
    private static function copyFileChunked(source:String, destination:String):Void {
    var input:FileInput = null;
    var output:FileOutput = null;

    try {
        input = File.read(source, true);
        output = File.write(destination, true);
        
        var buffer:Bytes = Bytes.alloc(BUFFER_SIZE);
        var readLen:Int = 0;

        while (true) {
            try {
                readLen = input.readBytes(buffer, 0, BUFFER_SIZE);
                if (readLen == 0) break;

                output.writeBytes(buffer, 0, readLen);
                bytesCopied += readLen;
            } catch (e:haxe.io.Eof) {
                break;
            }
        }
    } catch (e:Dynamic) {
        trace('Failed to copy file from $source to $destination. Reason: $e');
    }
    if (input != null) {
        try { input.close(); } catch (e:Dynamic) { trace("Error closing input stream."); }
    }
    if (output != null) {
        try { output.close(); } catch (e:Dynamic) { trace("Error closing output stream."); }
    }
 }
