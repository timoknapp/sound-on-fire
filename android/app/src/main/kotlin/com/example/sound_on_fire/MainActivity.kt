package com.example.sound_on_fire

import androidx.annotation.NonNull;
import com.github.javiersantos.appupdater.AppUpdater
import com.github.javiersantos.appupdater.enums.UpdateFrom
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

//TODO: App Center temporarily disabled
//import com.microsoft.appcenter.AppCenter
//import com.microsoft.appcenter.analytics.Analytics
//import com.microsoft.appcenter.crashes.Crashes
//import com.microsoft.appcenter.distribute.Distribute

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        //Distribute.setEnabledForDebuggableBuild(true)
        //AppCenter.start(application, "774cf36d-66c2-42cd-84b6-9147b5a8cc0f", Analytics::class.java, Crashes::class.java, Distribute::class.java)
        // AppUpdater
        val appUpdater = AppUpdater(this)
                .setUpdateFrom(UpdateFrom.JSON)
               .setUpdateJSON("https://raw.githubusercontent.com/timoknapp/sound-on-fire/master/app-update-changelog.json")
                .start()
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
