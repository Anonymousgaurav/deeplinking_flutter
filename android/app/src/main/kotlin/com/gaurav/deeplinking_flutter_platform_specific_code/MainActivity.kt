package com.gaurav.deeplinking_flutter_platform_specific_code

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import android.net.Uri

class MainActivity: FlutterActivity() {

    private val CHANNEL = "launchUrl"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "launchUrl")
            .setMethodCallHandler { call, result ->
                if (call.method == "openUrl") {
                    val url = call.arguments as String
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                    startActivity(intent)
                    result.success(null)
                } else {
                    result.notImplemented()
                }
        }
    }
}
