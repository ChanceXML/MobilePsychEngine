package backend;

#if cpp
@:cppFileCode('extern "C" void ios_show_alert(const char* title, const char* message);')
#end

class IOSNative
{
	#if cpp
	@:native("ios_show_alert")
	public static function showAlert(title:String, message:String):Void;
	#end

	#if !cpp
	public static function showAlert(title:String, message:String):Void {}
	#end
}
