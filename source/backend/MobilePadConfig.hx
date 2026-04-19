package backend;

class MobilePadConfig
{
	public var layout:String = "FULL";
	public var buttons:Array<String> = ["accept", "back"];

	public function new() {}

	public function buttonType()
	{
		return switch (buttons.length)
		{
			case 1 | 2: A_B;
			case 3 | 4: A_B_X_Y;
			default: A_B_X_Y;
		}
	}
}
