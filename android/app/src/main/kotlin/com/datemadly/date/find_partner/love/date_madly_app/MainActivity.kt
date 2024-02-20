package com.lovecirco.app

import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
