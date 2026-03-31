package android.utils;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxMath;

class Mouse extends FlxSprite {
    public var mouse:Bool = false;
    
    var lastTouchX:Float = 0;
    var lastTouchY:Float = 0;
    var isDragging:Bool = false;

    public function new() {
        super();
        
        loadGraphic("assets/shared/images/mouse/cursor-default.png");
        antialiasing = true;
        scrollFactor.set(0, 0);
        
        this.x = (FlxG.width - width) / 2;
        this.y = (FlxG.height - height) / 2;
    }

    override public function update(elapsed:Float):Void {
        #if (desktop || android)
        if (ClientPrefs.data != null) {
            mouse = ClientPrefs.data.mouse;
        }
        #end

        if (!mouse) {
            visible = false;
            return;
        }

        visible = true;
        FlxG.mouse.visible = false;

        var touch:FlxTouch = FlxG.touches.getFirst();

        if (touch != null) {
            if (touch.justPressed) {
                lastTouchX = touch.screenX;
                lastTouchY = touch.screenY;
                isDragging = true;
            } else if (touch.pressed && isDragging) {
                var deltaX:Float = touch.screenX - lastTouchX;
                var deltaY:Float = touch.screenY - lastTouchY;

                this.x += deltaX;
                this.y += deltaY;

                lastTouchX = touch.screenX;
                lastTouchY = touch.screenY;
            }
        } else {
            isDragging = false;
        }

        this.x = FlxMath.bound(this.x, 0, FlxG.width - width);
        this.y = FlxMath.bound(this.y, 0, FlxG.height - height);

        @:privateAccess {
            FlxG.mouse.x = Std.int(this.x);
            FlxG.mouse.y = Std.int(this.y);
            FlxG.mouse.screenX = Std.int(this.x);
            FlxG.mouse.screenY = Std.int(this.y);
        }

        super.update(elapsed);
    }

    public function setHoverState(isHovering:Bool):Void {
        if (!mouse) return;

        if (isHovering) {
            loadGraphic("assets/shared/images/mouse/cursor-pointer.png");
        } else {
            loadGraphic("assets/shared/images/mouse/cursor-default.png");
        }
    }
}
