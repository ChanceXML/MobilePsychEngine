#if android
import lime.system.JNI;
#end

class SAFBridge
{
    #if android

    static var openModsFolderPickerJNI = JNI.createStaticMethod(
        "com/shadowmario/psychengine/SAFBridge",
        "openModsFolderPicker",
        "()V"
    );

    public static function openModsFolderPicker():Void
    {
        openModsFolderPickerJNI();
    }

    #end
}
