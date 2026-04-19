package backend;

#if cpp
@:include("NativePopup.mm")
#end

class IOSNative
{
	#if cpp
	@:native("ios_show_alert")
	@:extern
	public static function showAlert(title:String, message:String):Void;
	#end

	#if !cpp
	public static function showAlert(title:String, message:String):Void {}
	#end
}
