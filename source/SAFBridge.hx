#if android
import lime.system.JNI;
#end

class SAFBridge
{
    #if android
    static var openModsFolderPickerJNI:Dynamic;

    static function init()
    {
        if (openModsFolderPickerJNI == null)
        {
            openModsFolderPickerJNI = JNI.createStaticMethod(
                "com.shadowmario.psychengine.SAFBridge",
                "openModsFolderPicker",
                "()V"
            );
        }
    }

    public static function openModsFolderPicker():Void
    {
        init();

        if (openModsFolderPickerJNI != null)
            openModsFolderPickerJNI();
    }
    #end
}
