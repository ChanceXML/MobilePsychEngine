package org.haxe.extension;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Looper;
import android.os.Handler;
import org.haxe.extension.Extension;

public class Tools extends Extension {
    public static void showMessage(final String title, final String message) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                AlertDialog.Builder builder = new AlertDialog.Builder(mainContext);
                builder.setTitle(title);
                builder.setMessage(message);
                builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.dismiss();
                    }
                });
                builder.setCancelable(false);
                AlertDialog dialog = builder.create();
                dialog.show();
            }
        });
    }
}
