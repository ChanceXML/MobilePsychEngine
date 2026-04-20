package com.shadowmario.psychengine;

import android.content.Intent;
import android.net.Uri;

public class SAFBridge {

    public static MainActivity activity;
    public static int REQUEST_CODE = 777;

    public static void openModsFolderPicker() {
        if (activity == null) return;

        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);

        activity.startActivityForResult(intent, REQUEST_CODE);
    }

    public static void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_CODE && resultCode == -1) {
            Uri uri = data.getData();

            AndroidModSync.setFolder(uri.toString());
        }
    }
}
