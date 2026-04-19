package org.haxe.extension;

import android.app.AlertDialog;
import android.os.Looper;

public class Tools extends Extension
{
    public static void showMessage(final String title, final String message)
    {
        if (mainActivity == null) return;

        mainActivity.runOnUiThread(new Runnable()
        {
            @Override
            public void run()
            {
                new AlertDialog.Builder(mainActivity)
                    .setTitle(title)
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton("OK", null)
                    .show();
            }
        });
    }
}
