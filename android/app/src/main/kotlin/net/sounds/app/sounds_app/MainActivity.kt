package net.sounds.app.sounds_app

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object{
        lateinit var channel: MethodChannel
    }

    private val CHANNEL = "net.sounds.app.sounds_app/setNotification"
    private val CHANNEL2 = "net.sounds.app.sounds_app/responceNotification"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)


        //start function from dart
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setNotification") {
                val isStart = setNotification()
                if (isStart != -1) {
                    result.success(isStart)
                } else {
                    result.error("UNAVAILABLE", "MediaPlayer service not started.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        //start dart functions from kotlin
        channel = MethodChannel(flutterView, CHANNEL2)

    }


    fun setNotification() : Int {
        val intent = Intent(applicationContext, MediaPlayerService::class.java)
        intent.action = MediaPlayerService.ACTION_PLAY
        startService(intent)
        return 1
    }
}


