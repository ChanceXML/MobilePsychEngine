package org.haxe.extension;

import android.app.Activity;
import android.app.ProgressDialog;

public class Extension {

    public static Activity mainActivity;
    private static ProgressDialog currentDialog;

    public static void setActivity(Activity activity) {
        mainActivity = activity;
    }

    public static void showLoading(String message) {
        if (mainActivity == null) return;

        mainActivity.runOnUiThread(() -> {
            try {
                currentDialog = new ProgressDialog(mainActivity);
                currentDialog.setMessage(message);
                currentDialog.setCancelable(false);
                currentDialog.show();
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public static void hideLoading() {
        if (mainActivity == null) return;

        mainActivity.runOnUiThread(() -> {
            try {
                if (currentDialog != null) {
                    currentDialog.dismiss();
                    currentDialog = null;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }
}
