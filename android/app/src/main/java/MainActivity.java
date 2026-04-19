public class MainActivity extends GameActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        SAFBridge.activity = this;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == SAFModImporter.REQUEST_CODE_PICK_FOLDER) {
            SAFModImporter.handleFolderResult(this, data);
        }
    }
}
