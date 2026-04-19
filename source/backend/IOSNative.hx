package backend;

@:cppFileCode('extern "C" void ios_show_alert(const char* title, const char* message);')

extern class IOSNative {
    public static function ios_show_alert(title:String, message:String):Void;
}
