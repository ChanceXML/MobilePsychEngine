package backend;

#if ios
@:native("ios_show_alert")
extern class IOSNative
{
    public static function ios_show_alert(title:String, message:String):Void;
}
#else
class IOSNative
{
    public static function ios_show_alert(title:String, message:String):Void {}
}
#end
