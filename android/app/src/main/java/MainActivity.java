package com.shadowmario.psychengine;

import android.os.Bundle;
import android.content.Intent;
import org.haxe.extension.Extension;
import org.haxe.lime.GameActivity;

public class MainActivity extends GameActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SAFBridge.activity = this;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == SAFModImporter.REQUEST_CODE_PICK_FOLDER && resultCode == -1) {
            SAFModImporter.handleFolderResult(this, data);
        }
    }
}
