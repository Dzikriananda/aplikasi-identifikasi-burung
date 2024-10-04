package com.dzikriananda.bird_guard

import android.os.Environment
import android.os.StatFs
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.dzikriananda.birdguard/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getStorageInfo") {
                val storageInfo = getStorageInfo()
                if (storageInfo != null) {
                    result.success(storageInfo)
                } else {
                    result.error("UNAVAILABLE", "Storage info not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getStorageInfo(): Map<String, Double>? {
        val statFs = StatFs(Environment.getDataDirectory().path)
//        val rawTotalStorage = statFs.blockSizeLong * statFs.blockCountLong
//        val rawAvailableStorage = statFs.blockSizeLong * statFs.availableBlocksLong
//        val totalBytes = statFs.totalBytes * 0.000000001
//        var totalStorage: Double = (rawTotalStorage/(1024f * 1024f * 1024f)).toDouble()
//        var availableStorage: Double = (rawAvailableStorage/(1024f * 1024f * 1024f)).toDouble()
        var totalStorage: Double = statFs.totalBytes * 0.000000001
        var availableStorage: Double = statFs.availableBytes * 0.000000001
        return mapOf("totalStorage" to totalStorage, "availableStorage" to availableStorage)
    }
}

