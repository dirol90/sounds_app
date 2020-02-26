import UIKit
import Flutter
import AVFoundation
import MediaPlayer

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {


 GeneratedPluginRegistrant.register(with: self)

 let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channelName = "net.sounds.app.sounds_app/ios_player"
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController.binaryMessenger)

  let commandCenter = MPRemoteCommandCenter.shared()
          commandCenter.playCommand.isEnabled = true
          commandCenter.pauseCommand.isEnabled = true

          commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
    methodChannel.invokeMethod("play", arguments: nil)
              return .success
          }
          commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
    methodChannel.invokeMethod("stop", arguments: nil)
              return .success
          }

MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "Dream Sounds - \(soundName)"]

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
