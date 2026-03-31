package android.utils;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxMath;
import openfl.utils.Assets;

class Mouse extends FlxSprite {
    public var mouseEnabled:Bool = false;
    
    var lastTouchX:Float = 0;
    var lastTouchY:Float = 0;
    var isDragging:Bool = false;
    
    public var mouseCamera:FlxCamera;

    public function new() {
        super();
        
        mouseCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        mouseCamera.bgColor = 0x00000000;
        FlxG.cameras.add(mouseCamera, false);
        
        this.cameras = [mouseCamera];
        
        loadCustomGraphic("cursor-default");
        antialiasing = true;
        scrollFactor.set(0, 0);
        
        this.x = FlxG.width / 2;
        this.y = FlxG.height / 2;
    }

    override public function update(elapsed:Float):Void {
        #if mobile
        if (ClientPrefs.data != null) {
            mouseEnabled = ClientPrefs.data.mouse;
        }
        #end

        if (!mouseEnabled) {
            visible = false;
            return;
        }

        visible = true;
        FlxG.mouse.visible = false;

        if (FlxG.cameras.list.indexOf(mouseCamera) != FlxG.cameras.list.length - 1) {
            FlxG.cameras.remove(mouseCamera, false);
            FlxG.cameras.add(mouseCamera, false);
        }

        var touch:FlxTouch = FlxG.touches.getFirst();

        @:privateAccess {
            if (touch != null) {
                if (touch.justPressed) {
                    lastTouchX = touch.screenX;
                    lastTouchY = touch.screenY;
                    isDragging = true;
                    FlxG.mouse._leftButton.press();
                } else if (touch.pressed && isDragging) {
                    this.x += (touch.screenX - lastTouchX);
                    this.y += (touch.screenY - lastTouchY);
                    
                    lastTouchX = touch.screenX;
                    lastTouchY = touch.screenY;
                } else if (touch.justReleased) {
                    isDragging = false;
                    FlxG.mouse._leftButton.release();
                }
            } else {
                isDragging = false;
                if (FlxG.mouse._leftButton.pressed) FlxG.mouse._leftButton.release();
            }

            this.x = FlxMath.bound(this.x, 0, FlxG.width);
            this.y = FlxMath.bound(this.y, 0, FlxG.height);

            FlxG.mouse.screenX = Std.int(this.x);
            FlxG.mouse.screenY = Std.int(this.y);
            
            if (FlxG.camera != null) {
                FlxG.mouse.x = Std.int((this.x / FlxG.camera.zoom) + FlxG.camera.scroll.x);
                FlxG.mouse.y = Std.int((this.y / FlxG.camera.zoom) + FlxG.camera.scroll.y);
            }
        }

        super.update(elapsed);
    }

    public function setHoverState(isHovering:Bool):Void {
        if (!mouseEnabled) return;
        loadCustomGraphic(isHovering ? "cursor-pointer" : "cursor-default");
    }

    private function loadCustomGraphic(name:String):Void {
        var path:String = "assets/images/mouse/" + name + ".png";
        if (Assets.exists(path)) {
            loadGraphic(path);
        } else {
            makeGraphic(15, 15, 0xFFFFFFFF);
        }
    }
    
    override public function destroy():Void {
        if (mouseCamera != null) {
            FlxG.cameras.remove(mouseCamera);
            mouseCamera = null;
        }
        super.destroy();
    }
}
