package options;

#if android
import lime.system.JNI;
#end

class AndroidSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Android Settings';
		rpcTitle = 'Android Settings Menu';

		var option:Option = new Option('Hitbox Opacity', // name
			'Set how transparent the hitbox is.', // description
			'hitboxOpacity', // variable name
			FLOAT);
		
		option.minValue = 0; 
		option.maxValue = 1;  
		option.changeValue = 0.1;
		option.decimals = 1;   
		option.scrollSpeed = 1.0;
		addOption(option);

		var option:Option = new Option('Hitbox Style',
			'Choose the visual style of the hitboxes.',
			'hitboxStyle',
			STRING,
			['Normal', 'Gradient']);
		addOption(option);

		var option:Option = new Option('Hints Opacity',
			'Opacity of the hints. put to 0 if u want them disabled.',
			'hitboxHint',
			FLOAT);
		
		option.minValue = 0; 
		option.maxValue = 1;  
		option.changeValue = 0.1;
		option.decimals = 1;   
		option.scrollSpeed = 1.0;
		addOption(option);

	    var option:Option = new Option('Hint Style',
			'Choose the visual style of the hints.',
			'hintStyle',
			STRING,
			['Bottom', 'Full']); // had to change the name because Hitbox Style and Hint Style would overlap
		addOption(option);

		var option:Option = new Option(
            'Mods Folder',
            'Select a folder to import mods from.',
            'modsFolderAction',
            STRING,
            ['Select Folder']
        ); 
        addOption(option);
		
		super();

	}
	
    override function update(elapsed:Float)
{
    super.update(elapsed);

    if (controls.ACCEPT)
    {
        var option = optionsArray[curSelected];

        if (option != null && option.variable == "modsFolderAction")
        {
            openModsPicker();
            return;
        }
    }
}

	function openModsPicker()
{
    #if android
    AndroidModSync.pickModsFolder();
    #end
    }
}
