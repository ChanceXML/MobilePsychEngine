package backend;

#if ios
@:cppFileCode('extern "C" void ios_show_alert(const char* title, const char* message);')
extern class IOSNative
{
    @:native("ios_show_alert")
    public static function showAlert(title:String, message:String):Void;
}
#else
class IOSNative
{
    public static function showAlert(title:String, message:String):Void {}
}
#end
