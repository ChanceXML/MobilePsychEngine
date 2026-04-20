package backend;

#if ios
// This tells the compiler to find and compile the objective-C++ file
// The path is relative to the project's export/ios/build folder
@:buildXml('<target id="haxe">
    <file name="../../../../source/native/ios/NativePopup.mm" />
</target>')
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
    
