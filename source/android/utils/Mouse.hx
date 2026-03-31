package android.utils;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxMath;

class Mouse extends FlxSprite {
    public var mouse:Bool = false;
    
    var lastTouchX:Float = 0;
    var lastTouchY:Float = 0;
    var isDragging:Bool = false;
    
    var prevX:Float = 0;
    var prevY:Float = 0;
    
    public var camMouse:FlxCamera;

    public function new() {
        super();
        
        camMouse = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        camMouse.bgColor = 0x00000000;
        camMouse.alpha = 1;
        FlxG.cameras.add(camMouse, false);
        
        this.cameras = [camMouse];
        
        loadCustomGraphic("cursor-default");
        antialiasing = true;
        scrollFactor.set(0, 0);
        
        this.x = (FlxG.width - width) / 2;
        this.y = (FlxG.height - height) / 2;
    }

    override public function update(elapsed:Float):Void {
        #if mobile
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

        if (FlxG.cameras.list != null && FlxG.cameras.list.length > 0) {
            if (FlxG.cameras.list[FlxG.cameras.list.length - 1] != camMouse) {
                FlxG.cameras.remove(camMouse, false);
                FlxG.cameras.add(camMouse, false);
            }
        }

        var touch:FlxTouch = FlxG.touches.getFirst();

        prevX = this.x;
        prevY = this.y;

        @:privateAccess {
            if (touch != null) {
                if (touch.justPressed) {
                    lastTouchX = touch.screenX;
                    lastTouchY = touch.screenY;
                    isDragging = true;
                    FlxG.mouse._leftButton.press();
                } else if (touch.pressed && isDragging) {
                    var deltaX:Float = touch.screenX - lastTouchX;
                    var deltaY:Float = touch.screenY - lastTouchY;

                    this.x += deltaX;
                    this.y += deltaY;

                    lastTouchX = touch.screenX;
                    lastTouchY = touch.screenY;
                } else if (touch.justReleased) {
                    isDragging = false;
                    FlxG.mouse._leftButton.release();
                }
            } else {
                isDragging = false;
                if (FlxG.mouse._leftButton.pressed) {
                    FlxG.mouse._leftButton.release();
                }
            }

            this.x = FlxMath.bound(this.x, 0, FlxG.width - width);
            this.y = FlxMath.bound(this.y, 0, FlxG.height - height);

            FlxG.mouse.screenX = Std.int(this.x);
            FlxG.mouse.screenY = Std.int(this.y);
            
            if (FlxG.camera != null) {
                FlxG.mouse.x = (this.x / FlxG.camera.zoom) + FlxG.camera.scroll.x;
                FlxG.mouse.y = (this.y / FlxG.camera.zoom) + FlxG.camera.scroll.y;
            } else {
                FlxG.mouse.x = Std.int(this.x);
                FlxG.mouse.y = Std.int(this.y);
            }

            if (this.x != prevX || this.y != prevY) {
                FlxG.mouse.justMoved = true;
            }
        }

        super.update(elapsed);
    }

    public function setHoverState(isHovering:Bool):Void {
        if (!mouse) return;
        loadCustomGraphic(isHovering ? "cursor-pointer" : "cursor-default");
    }

    private function loadCustomGraphic(name:String):Void {
        var imagePath:String = "mouse/" + name;
        try {
            var fallbackPath:String = "assets/images/" + imagePath + ".png";
            if (openfl.utils.Assets.exists(fallbackPath)) {
                loadGraphic(fallbackPath);
            }
        } catch(e:Dynamic) {
            visible = false;
            FlxG.mouse.visible = true;
        }
    }
    
    override public function destroy():Void {
        if (camMouse != null) {
            FlxG.cameras.remove(camMouse);
            camMouse.destroy();
        }
        super.destroy();
    }
}
