package com.shadowmario.psychengine;

import android.os.Bundle;
import android.content.Intent;
import org.haxe.lime.GameActivity;

public class MainActivity extends GameActivity {

    public static MainActivity instance;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        instance = this;

        SAFBridge.activity = this;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        SAFBridge.onActivityResult(requestCode, resultCode, data);
    }
}
