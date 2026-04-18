package android.controls;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

#if mobile
class HitboxHint extends FlxSpriteGroup
{
    public var hint:FlxSprite;
    public var camHint:FlxCamera;

    public function new()
    {
        super();

        camHint = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        camHint.bgColor = 0x00000000;
        camHint.zoom = 1;
        camHint.scroll.set(0, 0);
        camHint.pixelPerfectRender = false;
        camHint.alpha = ClientPrefs.data.hitboxHint;
        camHint.visible = ClientPrefs.data.hitboxHint > 0;
        FlxG.cameras.add(camHint, false);

        var hintGraphic = Paths.image(
            (ClientPrefs.data.hitboxStyle == 'Full')
            ? "mobile/hitbox/hitbox_hint_gradient"
            : "mobile/hitbox/hitbox_hint",
            "shared"
        );

        if (hintGraphic != null)
            hint = new FlxSprite().loadGraphic(hintGraphic);
        else
        {
            hint = new FlxSprite().makeGraphic(1, 1, 0x00FFFFFF);
            trace("ERROR: hitbox_hint.png not found!");
        }

        hint.scrollFactor.set(0, 0);
        hint.alpha = ClientPrefs.data.hitboxOpacity;
        hint.visible = true;
        hint.cameras = [camHint];

        add(hint);
    }
}
#end
