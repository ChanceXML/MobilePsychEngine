package com.shadowmario.psychengine;

import android.app.Activity;

public class SAFBridge {

    public static Activity activity;
    public static String lastTreeUri = null;

    public static void openModsFolderPicker() {
        if (activity == null) return;
        SAFModImporter.openFolderPicker(activity);
    }

    public static void syncMods() {
        if (activity == null || lastTreeUri == null) return;
        SAFModSync.sync(activity, lastTreeUri);
    }
}
