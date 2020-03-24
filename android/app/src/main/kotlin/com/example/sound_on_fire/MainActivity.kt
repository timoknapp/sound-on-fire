package com.example.sound_on_fire

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import com.microsoft.appcenter.distribute.Distribute

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        AppCenter.start(application, "774cf36d-66c2-42cd-84b6-9147b5a8cc0f", Analytics::class.java, Crashes::class.java, Distribute::class.java)
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
