package options;

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

		super();

		#if mobile
        virtualPad = ButtonHelper.create(this, FULL, A_B);

        ButtonHelper.bind(virtualPad,
    	['ui_up', 'ui_down', 'ui_left', 'ui_right'],
    	['accept', 'back']
        );

        Controls.virtualPad = virtualPad;
        #end
	}
}
